# /home/sysskel/myapps/jakeogh/dev-python/pylinalg/pylinalg-9999.ebuild

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

# Must come before inherit
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 git-r3

DESCRIPTION="Linear algebra utilities for Python"
HOMEPAGE="https://github.com/pygfx/pylinalg https://pylinalg.readthedocs.io/"
EGIT_REPO_URI="https://github.com/pygfx/pylinalg.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
"

BDEPEND="
	${RDEPEND}
	dev-python/hatchling[${PYTHON_USEDEP}]
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

