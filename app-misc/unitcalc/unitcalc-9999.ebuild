# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Convert units"
HOMEPAGE="https://github.com/jakeogh/unitcalc"
EGIT_REPO_URI="/home/cfg/_myapps/unitcalc https://github.com/jakeogh/unitcalc.git"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS=""

DEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pint[${PYTHON_USEDEP}]
	dev-python/python-levenshtein[${PYTHON_USEDEP}]
"

python_install_all() {
	distutils-r1_python_install_all
}
