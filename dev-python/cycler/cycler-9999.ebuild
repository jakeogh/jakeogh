# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

MY_PN="Cycler"

DESCRIPTION="Composable style cycles"
HOMEPAGE="
	https://matplotlib.org/cycler/
	https://pypi.org/project/Cycler/
	https://github.com/matplotlib/cycler"
EGIT_REPO_URI="https://github.com/matplotlib/cycler"

SLOT="0"
LICENSE="BSD"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
"

# Not shipped
# https://github.com/matplotlib/cycler/issues/21
RESTRICT=test

python_test() {
	nosetests --verbosity=3 || die
}
