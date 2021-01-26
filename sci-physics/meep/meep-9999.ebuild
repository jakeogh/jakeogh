# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#PYTHON_COMPAT=( python3_{8..9} )

inherit autotools git-r3

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/NanoComp/meep"
EGIT_REPO_URI="/home/cfg/_myapps/meep https://github.com/NanoComp/meep.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/click-command-tree[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

