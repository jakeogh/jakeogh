# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 git-r3

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/SymbiFlow/symbiflow-arch-defs"
EGIT_REPO_URI="/home/cfg/_myapps/symbiflow_arch_defs https://github.com/SymbiFlow/symbiflow-arch-defs.git"

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
