# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Library to extract data from Microsoft Excel spreadsheets"
HOMEPAGE="http://www.python-excel.org/"
EGIT_REPO_URI="https://github.com/python-excel/xlrd.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	# Remove this if examples get reintroduced
	sed -i -e "s/test_names_demo/_&/" tests/test_open_workbook.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m unittest discover || die "Test failed with ${EPYTHON}"
}
