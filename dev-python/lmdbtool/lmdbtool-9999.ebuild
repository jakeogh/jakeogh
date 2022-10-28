# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Another CLI for LMDB"
HOMEPAGE="https://github.com/jakeogh/lmdbtool"
EGIT_REPO_URI="/home/cfg/_myapps/lmdbtool https://github.com/jakeogh/lmdbtool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/lmdb[${PYTHON_USEDEP}]
	dev-python/with-lmdb[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
