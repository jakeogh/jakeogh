# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_12 python3_13 )

inherit python-r1 git-r3

DESCRIPTION="Datoviz (live git): Vulkan-based viz core + Python wrapper"
HOMEPAGE="https://github.com/datoviz/datoviz"
EGIT_REPO_URI="https://github.com/datoviz/datoviz.git"
EGIT_BRANCH="main"
# Submodules needed at build/runtime
EGIT_SUBMODULES=( data external/imgui )
# Repo uses LFS assets
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
	# Prevent any helper SDK downloads from Datoviz's build, if present
	export DVZ_DOWNLOAD_SDK=0
}

src_configure() {
	local libdir=$(get_libdir)

	# Gentoo CMake config locations for system libs
	local cglm_cmake="/usr/${libdir}/cmake/cglm"
	local tinyxml2_cmake="/usr/${libdir}/cmake/tinyxml2"
	local msdfgen_cmake="/usr/${libdir}/cmake/msdfgen"

	# Create a small CMake include that runs at top-level to
	# replace FetchContent for tinyxml2 and msdfgen-atlas with system packages.
	# This avoids network activity and satisfies later target/property usage.
	local top_include="${T}/gentoo_fetchcontent_overrides.cmake"
	cat > "${top_include}" <<'CMK'
# Run at top-level via CMAKE_PROJECT_TOP_LEVEL_INCLUDES
# Map Datoviz's FetchContent names to system packages.

# Provide minimal stubs that satisfy Datoviz's CMakeLists without downloading.
function(FetchContent_Declare name)
  # no-op; just record that something was declared
  set(FETCHCONTENT_DECLARE_${name} TRUE PARENT_SCOPE)
endfunction()

function(FetchContent_MakeAvailable)
  foreach(_name IN LISTS ARGV)
    if(_name STREQUAL "tinyxml2")
      find_package(tinyxml2 CONFIG QUIET)
      if(NOT TARGET tinyxml2::tinyxml2 AND NOT TARGET tinyxml2)
        find_package(TinyXML2 CONFIG QUIET)
      endif()
      if(TARGET tinyxml2::tinyxml2 AND NOT TARGET tinyxml2)
        add_library(tinyxml2 ALIAS tinyxml2::tinyxml2)
      endif()
      if(NOT TARGET tinyxml2 AND NOT TARGET tinyxml2::tinyxml2)
        message(FATAL_ERROR "System tinyxml2 not found. Install dev-libs/tinyxml2.")
      endif()

    elseif(_name STREQUAL "msdfgen-atlas")
      # System package typically exports msdfgen::msdfgen
      find_package(msdfgen CONFIG QUIET)
      if(TARGET msdfgen::msdfgen AND NOT TARGET msdfgen-atlas)
        add_library(msdfgen-atlas ALIAS msdfgen::msdfgen)
      endif()
      if(NOT TARGET msdfgen-atlas AND NOT TARGET msdfgen::msdfgen)
        message(FATAL_ERROR "System msdfgen not found. Install media-libs/msdfgen.")
      endif()

    else()
      # Any unexpected FetchContent request is forbidden under sandbox.
      message(FATAL_ERROR "FetchContent for '${_name}' is disabled under sandbox. Please provide a system package.")
    endif()
  endforeach()
endfunction()
CMK

	# Configure Datoviz C core
	cmake -S "${S}" -B "${CMAKE_BUILD_DIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SHARED_LIBS=ON \
		# Disallow any FetchContent population under Portage sandbox:
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON \
		# Help CMake find our system libs early:
		-DCMAKE_PREFIX_PATH="/usr/${libdir}/cmake;${cglm_cmake};${tinyxml2_cmake};${msdfgen_cmake}" \
		-Dcglm_DIR="${cglm_cmake}" \
		-DCGLM_DIR="${cglm_cmake}" \
		-Dtinyxml2_DIR="${tinyxml2_cmake}" \
		-DTinyXML2_DIR="${tinyxml2_cmake}" \
		-Dmsdfgen_DIR="${msdfgen_cmake}" \
		-DMSDFGEN_DIR="${msdfgen_cmake}" \
		# Inject our overrides before project() evaluates CMakeLists.txt:
		-DCMAKE_PROJECT_TOP_LEVEL_INCLUDES="${top_include}" \
		-G Ninja \
		|| die "cmake configure failed"
}

src_compile() {
	cmake --build "${CMAKE_BUILD_DIR}" || die "cmake build failed"
}

python_install() {
	# Install the pure-Python module tree
	python_domodule "${S}/datoviz" || die "failed to install Python module"

	# Install the C core where datoviz/_ctypes.py expects it
	local built_lib
	built_lib="$(find "${CMAKE_BUILD_DIR}" -type f -name 'libdatoviz.so' -print -quit)" \
		|| die "search for libdatoviz.so failed"
	[[ -n ${built_lib} ]] || die "libdatoviz.so not found; build likely failed"

	insinto "$(python_get_sitedir)/datoviz/build"
	doins "${built_lib}" || die "failed to install libdatoviz.so"
}

src_install() {
	python_foreach_impl python_install
	einstalldocs
}

pkg_postinst() {
	elog "Datoviz installed."
	elog "Python loads the C core from: site-packages/datoviz/build/libdatoviz.so"
	elog "Ensure a Vulkan ICD/driver is installed (Mesa or vendor)."
}

