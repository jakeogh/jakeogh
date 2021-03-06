# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3

DESCRIPTION="Recursively symlink the contents of a folder to another root"
HOMEPAGE="https://github.com/jakeogh/symlinktree"
EGIT_REPO_URI="/home/cfg/_myapps/symlinktree https://github.com/jakeogh/symlinktree.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/dirtool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
