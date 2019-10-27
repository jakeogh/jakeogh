# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Convert units"
HOMEPAGE="https://github.com/jakeogh/unitcalc"
EGIT_REPO_URI="/home/cfg/_myapps/unitcalc https://github.com/jakeogh/unitcalc.git"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS=""

#RDEPEND="!minimal? ( ${COMMON_DEPS} )"

DEPEND="
	dev-python/click
	dev-python/pint
	dev-python/python-levenshtein
"

python_install_all() {
    distutils-r1_python_install_all
}
