# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Module for creating simple ASCII tables"
HOMEPAGE="https://github.com/foutaise/texttable https://pypi.org/project/texttable/"
EGIT_REPO_URI="https://github.com/foutaise/texttable.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="cjk test"

RESTRICT="!test? ( test )"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/wcwidth[${PYTHON_USEDEP}]
		cjk? ( dev-python/cjkwrap[${PYTHON_USEDEP}] )
	)
"
RDEPEND="dev-python/wcwidth[${PYTHON_USEDEP}]
	cjk? ( dev-python/cjkwrap[${PYTHON_USEDEP}] )"

python_test() {
	pytest -vv tests.py || die
}
