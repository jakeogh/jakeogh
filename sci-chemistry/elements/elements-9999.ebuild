# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="List elements"
HOMEPAGE="https://github.com/jakeogh/elements"
#EGIT_REPO_URI="/home/cfg/_myapps/elements https://github.com/jakeogh/elements.git"
EGIT_REPO_URI="/home/cfg/_myapps/elements"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	sci-chemistry/mendeleev[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/texttable[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
