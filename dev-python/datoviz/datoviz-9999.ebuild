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

	# Top-level shim: replace FetchContent deps with REAL IMPORTED targets.
	local top_include="${T}/gentoo_fetchcontent_overrides.cmake"
	cat > "${top_include}" <<'CMK' || die "write override failed"
# Executed before project() via CMAKE_PROJECT_TOP_LEVEL_INCLUDES.
# Provide real IMPORTED targets for deps Datoviz otherwise FetchContent()s.
function(FetchContent_Declare)
  # no-op
endfunction()

function(_first_defined out)
  # helper: pick first defined CMake variable name from rest args
  foreach(_v IN LISTS ARGN)
    if(DEFINED ${_v})
      set(${out} "${${_v}}" PARENT_SCOPE)
      return()
    endif()
  endforeach()
  set(${out} "" PARENT_SCOPE)
endfunction()

function(_import_lib_as target libnames)
  # Create a real IMPORTED target with IMPORTED_LOCATION and include dirs.
  # Tries: existing CMake target -> pkg-config -> find_library -> headers
  # Args:
  #   target    : desired target name (e.g., tinyxml2)
  #   libnames  : semicolon-separated candidate library names (e.g., tinyxml2)
  set(_tgt "${target}")
  set(_names ${libnames})

  # If a config package already provided an imported target, wrap it as REAL imported.
  if(TARGET ${_tgt}::${_tgt})
    # Try to extract a concrete library file path from known config props.
    set(_loc "")
    foreach(cfg RELEASE RELWITHDEBINFO MINSIZEREL DEBUG "")
      if(NOT _loc STREQUAL "")
        break()
      endif()
      if(cfg STREQUAL "")
        get_target_property(_loc ${_tgt}::${_tgt} IMPORTED_LOCATION)
      else()
        get_target_property(_loc ${_tgt}::${_tgt} IMPORTED_LOCATION_${cfg})
      endif()
    endforeach()
    get_target_property(_inc ${_tgt}::${_tgt} INTERFACE_INCLUDE_DIRECTORIES)

    if(NOT _loc)
      # Fallback to find_library if config didn't expose a location
      find_library(_loc ${_names})
    endif()

    if(NOT _loc)
      message(FATAL_ERROR "Could not resolve library file for ${_tgt}")
    endif()

    add_library(${_tgt} SHARED IMPORTED)
    set_target_properties(${_tgt}
      PROPERTIES
        IMPORTED_LOCATION "${_loc}"
        INTERFACE_INCLUDE_DIRECTORIES "${_inc}"
    )
    # Keep link to namespaced target in case downstream expects it
    target_link_libraries(${_tgt} INTERFACE ${_tgt}::${_tgt})
    return()
  endif()

  # Try pkg-config
  find_package(PkgConfig QUIET)
  if(PkgConfig_FOUND)
    string(REPLACE ";" " " _pcnames "${_names}")
    # Pick the first name that pkg-config knows
    set(_pc_found FALSE)
    foreach(_pc ${_names})
      pkg_check_modules(PC_${_tgt} QUIET ${_pc})
      if(PC_${_tgt}_FOUND)
        set(_pc_found TRUE)
        break()
      endif()
    endforeach()
    if(_pc_found)
      # Resolve a full lib path (prefer PC var with absolute paths, else find_library)
      _first_defined(_liblist PC_${_tgt}_LINK_LIBRARIES PC_${_tgt}_LIBRARIES)
      set(_loc "")
      foreach(_cand IN LISTS _liblist)
        if(EXISTS "${_cand}")
          set(_loc "${_cand}")
          break()
        endif()
      endforeach()
      if(NOT _loc)
        # try common names
        find_library(_loc ${_names})
      endif()
      if(NOT _loc)
        message(FATAL_ERROR "pkg-config could not resolve lib file for ${_tgt}")
      endif()

      add_library(${_tgt} SHARED IMPORTED)
      set_target_properties(${_tgt}
        PROPERTIES
          IMPORTED_LOCATION "${_loc}"
          INTERFACE_INCLUDE_DIRECTORIES "${PC_${_tgt}_INCLUDE_DIRS}"
      )
      # Also propagate additional linker flags if any
      if(PC_${_tgt}_LDFLAGS_OTHER)
        target_link_options(${_tgt} INTERFACE ${PC_${_tgt}_LDFLAGS_OTHER})
      endif()
      return()
    endif()
  endif()

  # Last resort: find_library + common include roots
  find_library(_loc ${_names})
  if(NOT _loc)
    message(FATAL_ERROR "System ${_tgt} not found (no config, no pkg-config, no lib).")
  endif()
  # Heuristic includes
  set(_incs "")
  foreach(d /usr/include /usr/include/${_tgt} /usr/local/include /usr/local/include/${_tgt})
    if(EXISTS "${d}")
      list(APPEND _incs "${d}")
    endif()
  endforeach()

  add_library(${_tgt} SHARED IMPORTED)
  set_target_properties(${_tgt}
    PROPERTIES
      IMPORTED_LOCATION "${_loc}"
      INTERFACE_INCLUDE_DIRECTORIES "${_incs}"
  )
endfunction()

function(FetchContent_MakeAvailable)
  foreach(_name IN LISTS ARGV)

    if(_name STREQUAL "cglm")
      # Try config (Gentoo may ship cglm::cglm)
      find_package(cglm CONFIG QUIET)
      if(TARGET cglm::cglm)
        _import_lib_as(cglm "cglm")
      else()
        _import_lib_as(cglm "cglm")
      endif()

    elseif(_name STREQUAL "tinyxml2")
      find_package(tinyxml2 CONFIG QUIET)
      if(TARGET tinyxml2::tinyxml2)
        _import_lib_as(tinyxml2 "tinyxml2")
      else()
        _import_lib_as(tinyxml2 "tinyxml2")
      endif()

    elseif(_name STREQUAL "msdfgen-atlas")
      find_package(msdfgen CONFIG QUIET)
      if(TARGET msdfgen::msdfgen)
        # Provide a real 'msdfgen-atlas' IMPORTED target that points at libmsdfgen
        # (Datoviz later calls set_target_properties on 'msdfgen-atlas').
        # Resolve the actual lib file via config or find_library.
        # Reuse helper with name 'msdfgen' then alias the name expected by Datoviz.
        _import_lib_as(msdfgen "msdfgen")
        # Create a NON-ALIAS imported target under the expected name too
        get_target_property(_loc msdfgen IMPORTED_LOCATION)
        get_target_property(_incs msdfgen INTERFACE_INCLUDE_DIRECTORIES)
        add_library(msdfgen-atlas SHARED IMPORTED)
        set_target_properties(msdfgen-atlas
          PROPERTIES
            IMPORTED_LOCATION "${_loc}"
            INTERFACE_INCLUDE_DIRECTORIES "${_incs}"
        )
        target_link_libraries(msdfgen-atlas INTERFACE msdfgen::msdfgen)
      else()
        _import_lib_as(msdfgen-atlas "msdfgen")
      endif()

    elseif(_name STREQUAL "glfw")
      # Try configs (could be glfw3 or glfw)
      find_package(glfw3 CONFIG QUIET)
      if(NOT TARGET glfw)
        find_package(glfw CONFIG QUIET)
      endif()
      if(TARGET glfw)
        _import_lib_as(glfw "glfw;glfw3")
      else()
        _import_lib_as(glfw "glfw;glfw3")
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
	elog "Ensure a Vulkan ICD/driver is installed (Mesa or vendor)."
}

