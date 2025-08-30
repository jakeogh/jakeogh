# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Build the Python package via scikit-build-core (PEP 517) + CMake/Ninja
DISTUTILS_USE_PEP517=scikit-build-core

PYTHON_COMPAT=( python3_11 python3_12 python3_13 )

inherit distutils-r1 git-r3

DESCRIPTION="Datoviz: Vulkan-based high-performance scientific visualization (Python package)"
HOMEPAGE="https://datoviz.org https://github.com/datoviz/datoviz"
EGIT_REPO_URI="https://github.com/datoviz/datoviz.git"
EGIT_BRANCH="main"
EGIT_SUBMODULES=( '*' )

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""
PROPERTIES="live"

# Runtime libraries the built extension links against
RDEPEND="
	${PYTHON_DEPS}
	dev-python/numpy[${PYTHON_USEDEP}]
	media-libs/vulkan-loader
	media-libs/glfw
	media-libs/freetype:2
	dev-libs/tinyxml2
	dev-libs/cglm
"

# Headers/tools for building
DEPEND="
	${RDEPEND}
	dev-util/vulkan-headers
	dev-cpp/pybind11
"

BDEPEND="
	${PYTHON_DEPS}
	dev-build/cmake
	dev-build/ninja
	dev-python/scikit-build-core[${PYTHON_USEDEP}]
	virtual/pkgconfig
"

src_prepare() {
	default
	# Keep builds reproducible & avoid any helper downloads if upstream supports it
	export CMAKE_BUILD_TYPE=Release
	export DVZ_DOWNLOAD_SDK=0
}

# distutils-r1 handles the rest for PEP 517 projects.
#
# If we ever need to pass extra CMake opts for all impls, uncomment:
# python_configure_all() {
# 	export CMAKE_BUILD_PARALLEL_LEVEL=$(makeopts_jobs)
# 	export CMAKE_ARGS="${CMAKE_ARGS} -DDATOVIZ_USE_SYSTEM_DEPS=ON"
# }
