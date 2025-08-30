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
	export DVZ_DOWNLOAD_SDK=0
}

src_configure() {
	local libdir=$(get_libdir)
	local cglm_cmake="/usr/${libdir}/cmake/cglm"
	local tinyxml2_cmake="/usr/${libdir}/cmake/tinyxml2"
	local msdfgen_cmake="/usr/${libdir}/cmake/msdfgen"

	# Top-level shim: replace FetchContent deps with system packages (REAL imported targets).
	local top_include="${T}/gentoo_fetchcontent_overrides.cmake"
	cat > "${top_include}" <<'CMK' || die "write override failed"
# Executed before project() via CMAKE_PROJECT_TOP_LEVEL_INCLUDES.
# Provide non-alias IMPORTED targets for deps Datoviz otherwise FetchContent()s.

function(FetchContent_Declare)
  # no-op (we forbid downloading under sandbox)
endfunction()

# Helper: create or adapt a REAL IMPORTED target named <tgt>
# Prefer CMake config; then pkg-config; then find_library + common includes.
function(_ensure_imported_target tgt)
  if(TARGET ${tgt})
    return()
  endif()

  # If there's a namespaced config target ${tgt}::<something>, reuse its props.
  # Map common cases explicitly when needed.
  if("${tgt}" STREQUAL "cglm")
    find_package(cglm CONFIG QUIET)
    if(TARGET cglm::cglm)
      # Try to resolve a concrete lib path; fall back to -lcglm
      find_library(_loc cglm)
      get_target_property(_inc cglm::cglm INTERFACE_INCLUDE_DIRECTORIES)
      add_library(cglm UNKNOWN IMPORTED)
      if(_loc)
        set_target_properties(cglm PROPERTIES IMPORTED_LOCATION "${_loc}")
      endif()
      if(_inc)
        set_target_properties(cglm PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${_inc}")
      endif()
      return()
    endif()
  elseif("${tgt}" STREQUAL "tinyxml2")
    find_package(tinyxml2 CONFIG QUIET)
    if(TARGET tinyxml2::tinyxml2)
      find_library(_loc tinyxml2)
      get_target_property(_inc tinyxml2::tinyxml2 INTERFACE_INCLUDE_DIRECTORIES)
      add_library(tinyxml2 UNKNOWN IMPORTED)
      if(_loc)
        set_target_properties(tinyxml2 PROPERTIES IMPORTED_LOCATION "${_loc}")
      endif()
      if(_inc)
        set_target_properties(tinyxml2 PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${_inc}")
      endif()
      return()
    endif()
  elseif("${tgt}" STREQUAL "glfw")
    # Various configs export 'glfw' already; if so, do nothing.
    find_package(glfw3 CONFIG QUIET)
    if(TARGET glfw)
      return()
    endif()
    find_package(glfw CONFIG QUIET)
    if(TARGET glfw)
      return()
    endif()
  endif()

  # pkg-config fallback
  find_package(PkgConfig QUIET)
  if(PkgConfig_FOUND)
    if("${tgt}" STREQUAL "cglm")
      pkg_check_modules(PC_${tgt} QUIET cglm)
    elseif("${tgt}" STREQUAL "tinyxml2")
      pkg_check_modules(PC_${tgt} QUIET tinyxml2)
    elseif("${tgt}" STREQUAL "glfw")
      pkg_check_modules(PC_${tgt} QUIET glfw3)
    endif()
  endif()

  # Generic construction
  add_library(${tgt} UNKNOWN IMPORTED)

  # IMPORTED_LOCATION if we can resolve it
  if(DEFINED PC_${tgt}_LIBRARIES)
    # Prefer absolute paths in pkg-config libs; else try find_library
    set(_loc "")
    foreach(_cand IN LISTS PC_${tgt}_LIBRARIES)
      if(EXISTS "${_cand}")
        set(_loc "${_cand}")
        break()
      endif()
    endforeach()
    if(NOT _loc)
      if("${tgt}" STREQUAL "glfw")
        find_library(_loc NAMES glfw glfw3)
      else()
        find_library(_loc ${tgt})
      endif()
    endif()
    if(_loc)
      set_target_properties(${tgt} PROPERTIES IMPORTED_LOCATION "${_loc}")
    endif()
  else()
    if("${tgt}" STREQUAL "glfw")
      find_library(_loc NAMES glfw glfw3)
    else()
      find_library(_loc ${tgt})
    endif()
    if(_loc)
      set_target_properties(${tgt} PROPERTIES IMPORTED_LOCATION "${_loc}")
    endif()
  endif()

  # Interface includes
  if(DEFINED PC_${tgt}_INCLUDE_DIRS)
    set_target_properties(${tgt} PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${PC_${tgt}_INCLUDE_DIRS}")
  else()
    # Heuristic include roots
    foreach(_d /usr/include /usr/include/${tgt} /usr/local/include /usr/local/include/${tgt})
      if(EXISTS "${_d}")
        set_property(TARGET ${tgt} APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES "${_d}")
      endif()
    endforeach()
  endif()
endfunction()

function(FetchContent_MakeAvailable)
  foreach(_name IN LISTS ARGV)

    if(_name STREQUAL "cglm")
      _ensure_imported_target(cglm)

    elseif(_name STREQUAL "tinyxml2")
      _ensure_imported_target(tinyxml2)

    elseif(_name STREQUAL "glfw")
      # If CMake config already created 'glfw', do nothing.
      if(NOT TARGET glfw)
        _ensure_imported_target(glfw)
      endif()

    elseif(_name STREQUAL "msdfgen-atlas")
      if(TARGET msdfgen-atlas)
        # already provided
      else()
        # Prefer system CMake package exporting msdfgen::msdfgen-core/ext
        find_package(msdfgen CONFIG QUIET)
        if(TARGET msdfgen::msdfgen-core OR TARGET msdfgen::msdfgen-ext)
          # Create a non-alias imported target and link both components
          add_library(msdfgen-atlas UNKNOWN IMPORTED)
          # Includes from either target if provided
          get_target_property(_incs_core msdfgen::msdfgen-core INTERFACE_INCLUDE_DIRECTORIES)
          get_target_property(_incs_ext  msdfgen::msdfgen-ext  INTERFACE_INCLUDE_DIRECTORIES)
          if(_incs_core)
            set_property(TARGET msdfgen-atlas PROPERTY INTERFACE_INCLUDE_DIRECTORIES "${_incs_core}")
          elseif(_incs_ext)
            set_property(TARGET msdfgen-atlas PROPERTY INTERFACE_INCLUDE_DIRECTORIES "${_incs_ext}")
          else()
            # common headers path
            if(EXISTS "/usr/include/msdfgen")
              set_property(TARGET msdfgen-atlas PROPERTY INTERFACE_INCLUDE_DIRECTORIES "/usr/include/msdfgen")
            endif()
          endif()
          # Propagate link interface to the real libs/targets
          if(TARGET msdfgen::msdfgen-core)
            target_link_libraries(msdfgen-atlas INTERFACE msdfgen::msdfgen-core)
          endif()
          if(TARGET msdfgen::msdfgen-ext)
            target_link_libraries(msdfgen-atlas INTERFACE msdfgen::msdfgen-ext)
          endif()
        else()
          # Fallback: find_library for split libs
          find_library(MSDFGEN_CORE msdfgen-core)
          find_library(MSDFGEN_EXT  msdfgen-ext)
          if(NOT MSDFGEN_CORE AND NOT MSDFGEN_EXT)
            message(FATAL_ERROR "Could not find msdfgen-core/ext. Install media-libs/msdfgen.")
          endif()
          add_library(msdfgen-atlas UNKNOWN IMPORTED)
          if(EXISTS "/usr/include/msdfgen")
            set_property(TARGET msdfgen-atlas PROPERTY INTERFACE_INCLUDE_DIRECTORIES "/usr/include/msdfgen")
          endif()
          # Convey link requirements via interface (works for IMPORTED UNKNOWN)
          if(MSDFGEN_CORE)
            set_property(TARGET msdfgen-atlas APPEND PROPERTY INTERFACE_LINK_LIBRARIES "${MSDFGEN_CORE}")
          endif()
          if(MSDFGEN_EXT)
            set_property(TARGET msdfgen-atlas APPEND PROPERTY INTERFACE_LINK_LIBRARIES "${MSDFGEN_EXT}")
          endif()
        endif()
      endif()

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
	python_domodule "${S}/datoviz" || die "install python module failed"

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
	elog "System msdfgen provides split libs (core/ext) with a CMake package; we link both."
	elog "Ensure a Vulkan ICD/driver is installed (Mesa or vendor)."
}

