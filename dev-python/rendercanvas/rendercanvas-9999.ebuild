# /home/sysskel/myapps/jakeogh/dev-python/rendercanvas/rendercanvas-9999.ebuild

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

# Must be set before inheriting distutils-r1; upstream uses flit_core.buildapi
DISTUTILS_USE_PEP517=flit

inherit distutils-r1 git-r3

DESCRIPTION="Cross-platform GPU rendering canvas for Python"
HOMEPAGE="https://github.com/pygfx/rendercanvas"
EGIT_REPO_URI="https://github.com/pygfx/rendercanvas.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pylinalg[${PYTHON_USEDEP}]
"

BDEPEND="
	${RDEPEND}
	dev-python/flit-core[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

