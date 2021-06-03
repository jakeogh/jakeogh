# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3

DESCRIPTION="Merge hash indexed file trees"
HOMEPAGE="https://github.com/jakeogh/mergehashtree"
EGIT_REPO_URI="/home/cfg/_myapps/mergehashtree https://github.com/jakeogh/mergehashtree.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/kcl[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

