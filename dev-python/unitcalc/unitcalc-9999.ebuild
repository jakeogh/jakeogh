# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Convert units using pint"
HOMEPAGE="https://github.com/jakeogh/unitcalc"
EGIT_REPO_URI="/home/cfg/_myapps/unitcalc https://github.com/jakeogh/unitcalc.git"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pint[${PYTHON_USEDEP}]
	dev-python/python-levenshtein[${PYTHON_USEDEP}]
	dev-python/enumerate_input[${PYTHON_USEDEP}]
	dev-python/number-parser[${PYTHON_USEDEP}]
"

python_install_all() {
	distutils-r1_python_install_all
}
