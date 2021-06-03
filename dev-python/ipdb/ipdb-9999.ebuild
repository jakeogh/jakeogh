# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="IPython-enabled pdb"
HOMEPAGE="https://pypi.org/project/ipdb/"
EGIT_REPO_URI="https://github.com/gotcha/ipdb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/ipython[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	"

DOCS=( HISTORY.txt )

python_test() {
	esetup.py test
}
