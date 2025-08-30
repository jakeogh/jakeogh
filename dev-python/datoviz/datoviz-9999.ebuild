# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# We'll install the Python module with python-r1 helpers,
# and build the C core with CMake/Ninja ourselves.
PYTHON_COMPAT=( python3_12 python3_13 )

inherit python-r1 git-r3

DESCRIPTION="Datoviz (live git): Vulkan-based viz core + Python wrapper"
HOMEPAGE="https://github.com/datoviz/datoviz"
EGIT_REPO_URI="https://github.com/datoviz/datoviz.git"
EGIT_BRANCH="main"
# Pull only the submodules actually used at runtime/tests; broaden if needed.
EGIT_SUBMODULES=( data external/imgui )
# Repo uses Git LFS for some assets.
EGIT_LFS="yes"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""
PROPERTIES="live"

# Runtime deps: Python bits + the shared libs Datoviz needs at run-time.
RDEPEND="
	$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]')
	media-libs/vulkan-loader
	media-libs/glfw
	media-libs/freetype:2
	dev-libs/tinyxml2
	dev-libs/cglm
"

# Build-time deps (also needed at runtime are placed in RDEPEND above).
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

# CMake build directory for the C core
CMAKE_BUILD_DIR="${WORKDIR}/build-dvz"

src_prepare() {
	default
	# Ensure upstream doesn't attempt to download SDKs or similar during build.
	export DVZ_DOWNLOAD_SDK=0
}

src_configure() {
	# Help CMake locate system cglm and forbid FetchContent network activity.
	local libdir=$(get_libdir)
	local cglm_cmake="/usr/${libdir}/cmake/cglm"

	cmake -S "${S}" -B "${CMAKE_BUILD_DIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SHARED_LIBS=ON \
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON \
		-DCMAKE_PREFIX_PATH="/usr/${libdir}/cmake;${cglm_cmake}" \
		-Dcglm_DIR="${cglm_cmake}" \
		-DCGLM_DIR="${cglm_cmake}" \
		-G Ninja \
		|| die "cmake configure failed"
}

src_compile() {
	cmake --build "${CMAKE_BUILD_DIR}" || die "cmake build failed"
}

python_install() {
	# Install pure-Python package. In the upstream repo this directory is 'datoviz'.
	# If upstream ever relocates it, adjust this path accordingly.
	python_domodule "${S}/datoviz" || die "failed to install Python module"

	# Find the built shared lib and place it where datoviz/_ctypes.py expects it.
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
	elog "Python will load the C core from: site-packages/datoviz/build/libdatoviz.so"
	elog "Make sure a Vulkan ICD/driver is present (e.g., Mesa or vendor ICD)."
}

