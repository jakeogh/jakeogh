# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_12 python3_13 )
inherit python-r1 git-r3

DESCRIPTION="Datoviz (live git): Vulkan-based viz core + Python wrapper"
HOMEPAGE="https://github.com/datoviz/datoviz"
EGIT_REPO_URI="https://github.com/datoviz/datoviz.git"
EGIT_BRANCH="main"
# Submodules used at build/runtime
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
	# never download SDKs during build
	export DVZ_DOWNLOAD_SDK=0
}

src_configure() {
	local libdir=$(get_libdir)
	local cglm_cmake="/usr/${libdir}/cmake/cglm"
	local tinyxml2_cmake="/usr/${libdir}/cmake/tinyxml2"
	local msdfgen_cmake="/usr/${libdir}/cmake/msdfgen"

	# Top-level include that overrides FetchContent to use system packages.
	local top_include="${T}/gentoo_fetchcontent_overrides.cmake"
	cat > "${top_include}" <<'CMK' || die "write override failed"
# Executed before project() via CMAKE_PROJECT_TOP_LEVEL_INCLUDES.
# Replace FetchContent for cglm, tinyxml2, msdfgen-atlas with system packages.
function(FetchContent_Declare)
  # no-op
endfunction()

function(FetchContent_MakeAvailable)
  foreach(_name IN LISTS ARGV)

    if(_name STREQUAL "cglm")
      # Try CMake config first
      find_package(cglm CONFIG QUIET)
      if(TARGET cglm::cglm AND NOT TARGET cglm)
        add_library(cglm ALIAS cglm::cglm)
      endif()
      # Fallback: pkg-config
      if(NOT TARGET cglm AND NOT TARGET cglm::cglm)
        find_package(PkgConfig QUIET)
        if(PkgConfig_FOUND)
          pkg_check_modules(CGLM QUIET cglm)
        endif()
        if(CGLM_FOUND)
          add_library(cglm INTERFACE)
          target_include_directories(cglm INTERFACE ${CGLM_INCLUDE_DIRS})
          target_compile_options(cglm INTERFACE ${CGLM_CFLAGS_OTHER})
        elseif(EXISTS "/usr/include/cglm/cglm.h")
          add_library(cglm INTERFACE)
          target_include_directories(cglm INTERFACE /usr/include)
        else()
          message(FATAL_ERROR "System cglm not found. Install dev-libs/cglm.")
        endif()
      endif()

    elseif(_name STREQUAL "tinyxml2")
      # Try CMake config
      find_package(tinyxml2 CONFIG QUIET)
      if(TARGET tinyxml2::tinyxml2 AND NOT TARGET tinyxml2)
        add_library(tinyxml2 ALIAS tinyxml2::tinyxml2)
      endif()
      # Fallback: pkg-config
      if(NOT TARGET tinyxml2 AND NOT TARGET tinyxml2::tinyxml2)
        find_package(PkgConfig QUIET)
        if(PkgConfig_FOUND)
          pkg_check_modules(TINYXML2 QUIET tinyxml2)
        endif()
        if(TINYXML2_FOUND)
          add_library(tinyxml2 INTERFACE)
          target_include_directories(tinyxml2 INTERFACE ${TINYXML2_INCLUDE_DIRS})
          if(TINYXML2_LINK_LIBRARIES)
            target_link_libraries(tinyxml2 INTERFACE ${TINYXML2_LINK_LIBRARIES})
          elseif(TINYXML2_LIBRARIES)
            target_link_libraries(tinyxml2 INTERFACE ${TINYXML2_LIBRARIES})
          else()
            # common fallback
            target_link_libraries(tinyxml2 INTERFACE tinyxml2)
          endif()
        else()
          message(FATAL_ERROR "System tinyxml2 not found. Install dev-libs/tinyxml2.")
        endif()
      endif()

    elseif(_name STREQUAL "msdfgen-atlas")
      # Try CMake config (often exports msdfgen::msdfgen)
      find_package(msdfgen CONFIG QUIET)
      if(TARGET msdfgen::msdfgen AND NOT TARGET msdfgen-atlas)
        add_library(msdfgen-atlas ALIAS msdfgen::msdfgen)
      endif()
      # Fallback: pkg-config
      if(NOT TARGET msdfgen-atlas AND NOT TARGET msdfgen::msdfgen)
        find_package(PkgConfig QUIET)
        if(PkgConfig_FOUND)
          pkg_check_modules(MSDFGEN QUIET msdfgen)
        endif()
        if(MSDFGEN_FOUND)
          add_library(msdfgen-atlas INTERFACE)
          target_include_directories(msdfgen-atlas INTERFACE ${MSDFGEN_INCLUDE_DIRS})
          target_link_libraries(msdfgen-atlas INTERFACE ${MSDFGEN_LIBRARIES})
        else()
          message(FATAL_ERROR "System msdfgen not found. Install media-libs/msdfgen.")
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
	# Install pure-Python package
	python_domodule "${S}/datoviz" || die "install python module failed"

	# Install the C core where datoviz/_ctypes.py expects it
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

