# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Convert units using pint"
HOMEPAGE="https://github.com/jakeogh/unitcalc"
EGIT_REPO_URI="/home/sysskel/myapps/unitcalc https://github.com/jakeogh/unitcalc.git"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pint[${PYTHON_USEDEP}]
	dev-python/Levenshtein[${PYTHON_USEDEP}]
	dev-python/mptool[${PYTHON_USEDEP}]
	dev-python/number-parser[${PYTHON_USEDEP}]
	dev-python/unittool[${PYTHON_USEDEP}]
"

python_install_all() {
	distutils-r1_python_install_all
}
