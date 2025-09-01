# /home/sysskel/myapps/jakeogh/dev-python/cmap/cmap-9999.ebuild

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

# Must be set before inheriting distutils-r1; upstream uses flit_core.buildapi
DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 git-r3

DESCRIPTION="Scientific colormaps for Python with only numpy dependency"
HOMEPAGE="https://github.com/pyapp-kit/cmap https://cmap-docs.readthedocs.io/"
EGIT_REPO_URI="https://github.com/pyapp-kit/cmap.git"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
"

BDEPEND="
	${RDEPEND}
	dev-python/flit-core[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

