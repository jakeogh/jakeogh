# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit git-r3
inherit distutils-r1
inherit xdg

DESCRIPTION="Another CLI for LMDB"
HOMEPAGE="https://github.com/jakeogh/lmdb"
EGIT_REPO_URI="/home/cfg/_myapps/lmdb https://github.com/jakeogh/lmdb.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

src_prepare() {
	xdg_src_prepare
	default
}
