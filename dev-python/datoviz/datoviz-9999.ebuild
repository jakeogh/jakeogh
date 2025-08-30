# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_12 python3_13 )
inherit python-r1 git-r3

DESCRIPTION="Datoviz (live git): Vulkan-based viz core + Python wrapper"
HOMEPAGE="https://github.com/datoviz/datoviz"
EGIT_REPO_URI="https://github.com/datoviz/datoviz.git"
EGIT_BRANCH="main"
EGIT_SUBMODULES=( data external/imgui )
EGIT_LFS="yes"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""
PROPERTIES="live"

RDEPEND="
	$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]')
	media-libs/vulkan-loader
	media-libs/glfw
	media-libs/freetype:2
	dev-libs/tinyxml2
	dev-libs/cglm
	media-libs/msdfgen
"
DEPEND="
	${RDEPEND}
	dev-util/vulkan-headers
"
BDEPEND="
	virtual/pkgconfig
	dev-build/cmake
	dev-build/ninja
	dev-vcs/git-lfs
"

CMAKE_BUILD_DIR="${WORKDIR}/build-dvz"

src_prepare() {
	default
	# forbid any helper downloads
	export DVZ_DOWNLOAD_SDK=0
}

src_configure() {
	local libdir=$(get_libdir)
	local cglm_cmake="/usr/${libdir}/cmake/cglm"
	local tinyxml2_cmake="/usr/${libdir}/cmake/tinyxml2"
	local msdfgen_cmake="/usr/${libdir}/cmake/msdfgen"

	# Inject a top-level CMake include to replace FetchContent deps with system ones.
	local top_include="${T}/gentoo_fetchcontent_overrides.cmake"
	cat > "${top_include}" <<'CMK' || die "write override failed"
# Executed before project() via CMAKE_PROJECT_TOP_LEVEL_INCLUDES.
# Provide system deps for Datoviz without any FetchContent network.

function(FetchContent_Declare)
  # no-op
endfunction()

# --- helpers ---------------------------------------------------------------

function(_ensure_cglm)
  if(TARGET cglm)
    return()
  endif()

  find_package(cglm CONFIG QUIET)
  if(TARGET cglm::cglm)
    find_library(CGLM_LIB cglm)
    get_target_property(CGLM_INC cglm::cglm INTERFACE_INCLUDE_DIRECTORIES)
    add_library(cglm UNKNOWN IMPORTED)
    if(CGLM_LIB)
      set_target_properties(cglm PROPERTIES IMPORTED_LOCATION "${CGLM_LIB}")
    endif()
    if(CGLM_INC)
      set_target_properties(cglm PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${CGLM_INC}")
    endif()
    return()
  endif()

  find_package(PkgConfig QUIET)
  if(PkgConfig_FOUND)
    pkg_check_modules(PC_CGLM QUIET cglm)
  endif()

  add_library(cglm UNKNOWN IMPORTED)
  set(_loc "")
  if(DEFINED PC_CGLM_LIBRARIES)
    foreach(_cand IN LISTS PC_CGLM_LIBRARIES)
      if(EXISTS "${_cand}")
        set(_loc "${_cand}")
        break()
      endif()
    endforeach()
  endif()
  if(NOT _loc)
    find_library(_loc cglm)
  endif()
  if(_loc)
    set_target_properties(cglm PROPERTIES IMPORTED_LOCATION "${_loc}")
  endif()
  if(DEFINED PC_CGLM_INCLUDE_DIRS)
    set_target_properties(cglm PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${PC_CGLM_INCLUDE_DIRS}")
  elseif(EXISTS "/usr/include/cglm")
    set_target_properties(cglm PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "/usr/include")
  endif()
endfunction()

function(_ensure_tinyxml2)
  if(TARGET tinyxml2)
    return()
  endif()

  find_package(tinyxml2 CONFIG QUIET)
  if(TARGET tinyxml2::tinyxml2)
    find_library(TXML2_LIB tinyxml2)
    get_target_property(TXML2_INC tinyxml2::tinyxml2 INTERFACE_INCLUDE_DIRECTORIES)
    add_library(tinyxml2 UNKNOWN IMPORTED)
    if(TXML2_LIB)
      set_target_properties(tinyxml2 PROPERTIES IMPORTED_LOCATION "${TXML2_LIB}")
    endif()
    if(TXML2_INC)
      set_target_properties(tinyxml2 PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${TXML2_INC}")
    endif()
    return()
  endif()

  find_package(PkgConfig QUIET)
  if(PkgConfig_FOUND)
    pkg_check_modules(PC_TXML2 QUIET tinyxml2)
  endif()

  add_library(tinyxml2 UNKNOWN IMPORTED)
  set(_loc "")
  if(DEFINED PC_TXML2_LIBRARIES)
    foreach(_cand IN LISTS PC_TXML2_LIBRARIES)
      if(EXISTS "${_cand}")
        set(_loc "${_cand}")
        break()
      endif()
    endforeach()
  endif()
  if(NOT _loc)
    find_library(_loc tinyxml2)
  endif()
  if(_loc)
    set_target_properties(tinyxml2 PROPERTIES IMPORTED_LOCATION "${_loc}")
  endif()
  if(DEFINED PC_TXML2_INCLUDE_DIRS)
    set_target_properties(tinyxml2 PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${PC_TXML2_INCLUDE_DIRS}")
  endif()
endfunction()

function(_ensure_glfw)
  # If a 'glfw' target already exists (from a config), don't recreate it.
  if(TARGET glfw)
    return()
  endif()

  # Try configs that may define 'glfw' already.
  find_package(glfw3 CONFIG QUIET)
  if(TARGET glfw)
    return()
  endif()
  find_package(glfw CONFIG QUIET)
  if(TARGET glfw)
    return()
  endif()

  # Fallback: pkg-config and/or find_library
  find_package(PkgConfig QUIET)
  if(PkgConfig_FOUND)
    pkg_check_modules(PC_GLFW QUIET glfw3)
  endif()

  add_library(glfw UNKNOWN IMPORTED)

  set(_loc "")
  if(DEFINED PC_GLFW_LIBRARIES)
    foreach(_cand IN LISTS PC_GLFW_LIBRARIES)
      if(EXISTS "${_cand}")
        set(_loc "${_cand}")
        break()
      endif()
    endforeach()
  endif()
  if(NOT _loc)
    find_library(_loc NAMES glfw glfw3)
  endif()
  if(_loc)
    set_target_properties(glfw PROPERTIES IMPORTED_LOCATION "${_loc}")
  endif()
  if(DEFINED PC_GLFW_INCLUDE_DIRS)
    set_target_properties(glfw PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${PC_GLFW_INCLUDE_DIRS}")
  endif()
endfunction()

# Provide BOTH names Datoviz might reference:
#   - msdf-atlas-gen::msdf-atlas-gen   (namespaced target it links to)
#   - msdfgen-atlas                    (plain name some scripts refer to)
# Make them INTERFACE IMPORTED targets so no LOCATION is required; they just
# forward link interface to the real msdfgen libs (core/ext or monolithic).
function(_ensure_msdfgen)
  if(TARGET msdf-atlas-gen::msdf-atlas-gen AND TARGET msdfgen-atlas)
    return()
  endif()

  # Prefer system CMake package (can export split or monolithic)
  find_package(msdfgen CONFIG QUIET)
  if(TARGET msdfgen::msdfgen-core OR TARGET msdfgen::msdfgen-ext OR TARGET msdfgen::msdfgen)
    if(NOT TARGET msdfgen-atlas)
      add_library(msdfgen-atlas INTERFACE IMPORTED)
    endif()
    if(NOT TARGET msdf-atlas-gen::msdf-atlas-gen)
      add_library(msdf-atlas-gen::msdf-atlas-gen INTERFACE IMPORTED)
    endif()

    # Propagate includes if available
    get_target_property(_inc_core msdfgen::msdfgen-core INTERFACE_INCLUDE_DIRECTORIES)
    get_target_property(_inc_ext  msdfgen::msdfgen-ext  INTERFACE_INCLUDE_DIRECTORIES)
    get_target_property(_inc_mon  msdfgen::msdfgen      INTERFACE_INCLUDE_DIRECTORIES)
    if(_inc_core)
      set_target_properties(msdfgen-atlas PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${_inc_core}")
      set_target_properties(msdf-atlas-gen::msdf-atlas-gen PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${_inc_core}")
    elseif(_inc_ext)
      set_target_properties(msdfgen-atlas PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${_inc_ext}")
      set_target_properties(msdf-atlas-gen::msdf-atlas-gen PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${_inc_ext}")
    elseif(_inc_mon)
      set_target_properties(msdfgen-atlas PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${_inc_mon}")
      set_target_properties(msdf-atlas-gen::msdf-atlas-gen PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${_inc_mon}")
    elseif(EXISTS "/usr/include/msdfgen")
      set_target_properties(msdfgen-atlas PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "/usr/include/msdfgen")
      set_target_properties(msdf-atlas-gen::msdf-atlas-gen PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "/usr/include/msdfgen")
    endif()

    # Forward to whatever the package provides
    if(TARGET msdfgen::msdfgen-core)
      target_link_libraries(msdfgen-atlas INTERFACE msdfgen::msdfgen-core)
      target_link_libraries(msdf-atlas-gen::msdf-atlas-gen INTERFACE msdfgen::msdfgen-core)
    endif()
    if(TARGET msdfgen::msdfgen-ext)
      target_link_libraries(msdfgen-atlas INTERFACE msdfgen::msdfgen-ext)
      target_link_libraries(msdf-atlas-gen::msdf-atlas-gen INTERFACE msdfgen::msdfgen-ext)
    endif()
    if(TARGET msdfgen::msdfgen)
      target_link_libraries(msdfgen-atlas INTERFACE msdfgen::msdfgen)
      target_link_libraries(msdf-atlas-gen::msdf-atlas-gen INTERFACE msdfgen::msdfgen)
    endif()
    return()
  endif()

  # Fallback: discover split/mono libs directly
  find_library(MSDFGEN_CORE msdfgen-core)
  find_library(MSDFGEN_EXT  msdfgen-ext)
  find_library(MSDFGEN_MONO msdfgen)
  if(NOT MSDFGEN_CORE AND NOT MSDFGEN_EXT AND NOT MSDFGEN_MONO)
    message(FATAL_ERROR "Could not find msdfgen (core/ext/mono). Install media-libs/msdfgen.")
  endif()

  if(NOT TARGET msdfgen-atlas)
    add_library(msdfgen-atlas INTERFACE IMPORTED)
  endif()
  if(NOT TARGET msdf-atlas-gen::msdf-atlas-gen)
    add_library(msdf-atlas-gen::msdf-atlas-gen INTERFACE IMPORTED)
  endif()

  if(EXISTS "/usr/include/msdfgen")
    set_target_properties(msdfgen-atlas PROPERTIES                 INTERFACE_INCLUDE_DIRECTORIES "/usr/include/msdfgen")
    set_target_properties(msdf-atlas-gen::msdf-atlas-gen PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "/usr/include/msdfgen")
  endif()

  # Forward the actual found libs
  if(MSDFGEN_CORE)
    set_property(TARGET msdfgen-atlas                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES "${MSDFGEN_CORE}")
    set_property(TARGET msdf-atlas-gen::msdf-atlas-gen APPEND PROPERTY INTERFACE_LINK_LIBRARIES "${MSDFGEN_CORE}")
  endif()
  if(MSDFGEN_EXT)
    set_property(TARGET msdfgen-atlas                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES "${MSDFGEN_EXT}")
    set_property(TARGET msdf-atlas-gen::msdf-atlas-gen APPEND PROPERTY INTERFACE_LINK_LIBRARIES "${MSDFGEN_EXT}")
  endif()
  if(MSDFGEN_MONO)
    set_property(TARGET msdfgen-atlas                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES "${MSDFGEN_MONO}")
    set_property(TARGET msdf-atlas-gen::msdf-atlas-gen APPEND PROPERTY INTERFACE_LINK_LIBRARIES "${MSDFGEN_MONO}")
  endif()
endfunction()

# --- override FetchContent -------------------------------------------------

function(FetchContent_MakeAvailable)
  foreach(_name IN LISTS ARGV)
    if(_name STREQUAL "cglm")
      _ensure_cglm()
    elseif(_name STREQUAL "tinyxml2")
      _ensure_tinyxml2()
    elseif(_name STREQUAL "glfw")
      _ensure_glfw()
    elseif(_name STREQUAL "msdfgen-atlas" OR _name STREQUAL "msdf-atlas-gen")
      _ensure_msdfgen()
    else()
      message(FATAL_ERROR "FetchContent for '${_name}' is disabled under sandbox. Provide a system package.")
    endif()
  endforeach()
endfunction()
CMK

	cmake \
		-S "${S}" \
		-B "${CMAKE_BUILD_DIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SHARED_LIBS=ON \
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON \
		-DCMAKE_PREFIX_PATH="/usr/${libdir}/cmake;${cglm_cmake};${tinyxml2_cmake};${msdfgen_cmake}" \
		-Dcglm_DIR="${cglm_cmake}" \
		-DCGLM_DIR="${cglm_cmake}" \
		-Dtinyxml2_DIR="${tinyxml2_cmake}" \
		-DTinyXML2_DIR="${tinyxml2_cmake}" \
		-Dmsdfgen_DIR="${msdfgen_cmake}" \
		-DMSDFGEN_DIR="${msdfgen_cmake}" \
		-DCMAKE_PROJECT_TOP_LEVEL_INCLUDES="${top_include}" \
		-G Ninja \
		|| die "cmake configure failed"
}

src_compile() {
	cmake --build "${CMAKE_BUILD_DIR}" || die "cmake build failed"
}

python_install() {
	# install pure-Python module
	python_domodule "${S}/datoviz" || die "install python module failed"

	# install the C core where the Python loader expects it
	local built_lib
	built_lib="$(find "${CMAKE_BUILD_DIR}" -type f -name 'libdatoviz.so' -print -quit)" || die
	[[ -n ${built_lib} ]] || die "libdatoviz.so not found"

	insinto "$(python_get_sitedir)/datoviz/build"
	doins "${built_lib}" || die
}

src_install() {
	python_foreach_impl python_install
	einstalldocs
}

pkg_postinst() {
	elog "Datoviz installed. Python loads: site-packages/datoviz/build/libdatoviz.so"
	elog "Using system glfw, cglm, tinyxml2, and msdfgen (core/ext or mono)."
}

