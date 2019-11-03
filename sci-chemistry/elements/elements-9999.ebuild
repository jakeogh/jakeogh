# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_6 )

inherit distutils-r1 git-r3

DESCRIPTION="Short explination of what it does _here_"
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
