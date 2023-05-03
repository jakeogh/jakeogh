# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

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
	
"

DEPEND="${RDEPEND}"

