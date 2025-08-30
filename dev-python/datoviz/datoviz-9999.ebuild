# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Upstream uses setuptools.build_meta
DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_11 python3_12 python3_13 )

inherit distutils-r1 git-r3

DESCRIPTION="Datoviz: Vulkan-based high-performance scientific visualization (Python package + C core)"
HOMEPAGE="https://datoviz.org https://github.com/datoviz/datoviz"
EGIT_REPO_URI="https://github.com/datoviz/datoviz.git"
EGIT_BRANCH="main"
# Repo uses submodules and Git LFS assets
EGIT_SUBMODULES=( '*' )
EGIT_LFS="yes"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""
PROPERTIES="live"

# Runtime deps for Python wrapper and the lib it loads
RDEPEND="
	${PYTHON_DEPS}
	dev-python/numpy[${PYTHON_USEDEP}]
	media-libs/vulkan-loader
	media-libs/glfw
	media-libs/freetype:2
	dev-libs/tinyxml2
	dev-libs/cglm
"

# Build deps: headers + tools
DEPEND="
	${RDEPEND}
	dev-util/vulkan-headers
	dev-python/pybind11
"

BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
	dev-build/cmake
	dev-build/ninja
	dev-vcs/git-lfs
"

# We'll compile the C core once with CMake/Ninja, then install Python
# and drop the shared lib where datoviz/_ctypes.py expects it.
CMAKE_BUILD_DIR="${WORKDIR}/build-dvz"

src_prepare() {
	default
	# avoid helper downloads if any
	export DVZ_DOWNLOAD_SDK=0
}

src_configure() {
	# Configure C core with CMake
	cmake -S "${S}" -B "${CMAKE_BUILD_DIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SHARED_LIBS=ON \
		-G Ninja || die "cmake configure failed"
}

src_compile() {
	# Build C core
	cmake --build "${CMAKE_BUILD_DIR}" || die "cmake build failed"

	# Build the Python package (PEP517 setuptools)
	distutils-r1_src_compile
}

python_install() {
	distutils-r1_python_install

	# Locate the built shared library (libdatoviz.so)
	local built_lib
	built_lib="$(find "${CMAKE_BUILD_DIR}" -type f -name 'libdatoviz.so' -print -quit)" \
		|| die "search for libdatoviz.so failed"

	[[ -n ${built_lib} ]] || die "libdatoviz.so not found; build likely failed"

	# Place it where datoviz/_ctypes.py looks:
	#   site-packages/datoviz/build/libdatoviz.so
	local pydir="$(python_get_sitedir)"
	local target_dir="${D}${pydir}/datoviz/build"
	dodir "${target_dir#${D}}"
	cp "${built_lib}" "${target_dir}/libdatoviz.so" || die "failed to install libdatoviz.so"
}

pkg_postinst() {
	elog "Datoviz installed. The Python module loads libdatoviz.so from:"
	elog "  site-packages/datoviz/build/libdatoviz.so (per-impl)."
	elog "Ensure a Vulkan ICD/driver is installed (Mesa or vendor)."
}


