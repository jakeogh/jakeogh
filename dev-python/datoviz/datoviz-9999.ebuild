# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_12 python3_13 )

inherit python-r1 git-r3

DESCRIPTION="Datoviz (live git): Vulkan-based viz core + Python wrapper"
HOMEPAGE="https://github.com/datoviz/datoviz"
EGIT_REPO_URI="https://github.com/datoviz/datoviz.git"
EGIT_BRANCH="main"
# Only needed submodules; widen if upstream starts using more.
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

# Apply patches to prefer system tinyxml2/msdfgen over FetchContent.
PATCHES=(
	"${FILESDIR}"/0001-prefer-system-tinyxml2-and-normalize-target.patch
	"${FILESDIR}"/0002-prefer-system-msdfgen-and-normalize-target.patch
)

CMAKE_BUILD_DIR="${WORKDIR}/build-dvz"

src_prepare() {
	default
	# No network helpers at build time
	export DVZ_DOWNLOAD_SDK=0
}

src_configure() {
	local libdir=$(get_libdir)

	# CMake config dirs we expect on Gentoo
	local cglm_cmake="/usr/${libdir}/cmake/cglm"
	local tinyxml2_cmake="/usr/${libdir}/cmake/tinyxml2"
	local msdfgen_cmake="/usr/${libdir}/cmake/msdfgen"

	cmake -S "${S}" -B "${CMAKE_BUILD_DIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SHARED_LIBS=ON \
		# Disallow any FetchContent downloads under sandbox:
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON \
		# Help CMake find our system libs so it doesn't try to fetch:
		-DCMAKE_PREFIX_PATH="/usr/${libdir}/cmake;${cglm_cmake};${tinyxml2_cmake};${msdfgen_cmake}" \
		-Dcglm_DIR="${cglm_cmake}" \
		-DCGLM_DIR="${cglm_cmake}" \
		-Dtinyxml2_DIR="${tinyxml2_cmake}" \
		-DTinyXML2_DIR="${tinyxml2_cmake}" \
		-Dmsdfgen_DIR="${msdfgen_cmake}" \
		-DMSDFGEN_DIR="${msdfgen_cmake}" \
		-G Ninja \
		|| die "cmake configure failed"
}

src_compile() {
	cmake --build "${CMAKE_BUILD_DIR}" || die "cmake build failed"
}

python_install() {
	# Install pure-Python sources
	python_domodule "${S}/datoviz" || die "failed to install Python module"

	# Drop the built shared lib where the Python ctypes loader looks:
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
	elog "Datoviz installed. Python will load the C core from:"
	elog "  site-packages/datoviz/build/libdatoviz.so (per-impl)."
	elog "Ensure a Vulkan ICD/driver is installed (Mesa or vendor)."
}

