# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Upstream uses setuptools.build_meta in pyproject.toml
DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_11 python3_12 python3_13 )

inherit distutils-r1 git-r3

DESCRIPTION="Datoviz: Vulkan-based high-performance scientific visualization (Python package)"
HOMEPAGE="https://datoviz.org https://github.com/datoviz/datoviz"
EGIT_REPO_URI="https://github.com/datoviz/datoviz.git"
EGIT_BRANCH="main"
# Repo includes submodules and LFS assets
EGIT_SUBMODULES=( '*' )
EGIT_LFS="yes"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""
PROPERTIES="live"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/numpy[${PYTHON_USEDEP}]
	media-libs/vulkan-loader
	media-libs/glfw
	media-libs/freetype:2
	dev-libs/tinyxml2
	dev-libs/cglm
"
DEPEND="
	${RDEPEND}
	dev-util/vulkan-headers
	dev-cpp/pybind11
"
BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
	dev-vcs/git-lfs
"

src_prepare() {
	default
	# Keep builds reproducible & avoid any helper downloads if upstream honors them.
	export CMAKE_BUILD_TYPE=Release
	export DVZ_DOWNLOAD_SDK=0
}


# distutils-r1 will drive the setuptools PEP517 backend automatically.
