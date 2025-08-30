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

	# Inject a tiny override so FetchContent uses system packages instead.
	local top_include="${T}/gentoo_fetchcontent_overrides.cmake"
	cat > "${top_include}" <<'CMK' || die "write override failed"
# Executed before project() via CMAKE_PROJECT_TOP_LEVEL_INCLUDES.
# Replace Datoviz's FetchContent for cglm, tinyxml2, msdfgen-atlas with system libs.

function(FetchContent_Declare) endfunction()

function(FetchContent_MakeAvailable)
  foreach(_name IN LISTS ARGV)

    if(_name STREQUAL "cglm")
      # System cglm usually exports target cglm::cglm (Gentoo dev-libs/cglm).
      find_package(cglm CONFIG QUIET)
      if(NOT TARGET cglm::cglm AND NOT TARGET cglm)
        message(FATAL_ERROR "System cglm not found. Install dev-libs/cglm.")
      endif()
      if(TARGET cglm::cglm AND NOT TARGET cglm)
        add_library(cglm ALIAS cglm::cglm)
      endif()

    elseif(_name STREQUAL "tinyxml2")
      find_package(tinyxml2 CONFIG QUIET)
      if(NOT TARGET tinyxml2::tinyxml2 AND NOT TARGET tinyxml2)
        find_package(TinyXML2 CONFIG QUIET)
      endif()
      if(NOT TARGET tinyxml2 AND NOT TARGET tinyxml2::tinyxml2)
        message(FATAL_ERROR "System tinyxml2 not found. Install dev-libs/tinyxml2.")
      endif()
      if(TARGET tinyxml2::tinyxml2 AND NOT TARGET tinyxml2)
        add_library(tinyxml2 ALIAS tinyxml2::tinyxml2)
      endif()

    elseif(_name STREQUAL "msdfgen-atlas")
      find_package(msdfgen CONFIG QUIET)
      if(NOT TARGET msdfgen::msdfgen AND NOT TARGET msdfgen-atlas)
        message(FATAL_ERROR "System msdfgen not found. Install media-libs/msdfgen.")
      endif()
      if(TARGET msdfgen::msdfgen AND NOT TARGET msdfgen-atlas)
        add_library(msdfgen-atlas ALIAS msdfgen::msdfgen)
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

