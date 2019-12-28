# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Symbolic constants in Python"
HOMEPAGE="https://github.com/twisted/constantly https://pypi.org/project/constantly/"
EGIT_REPO_URI="https://github.com/twisted/constantly.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=""
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/twisted[${PYTHON_USEDEP}] )
"

python_test() {
	esetup.py test
}
