# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit git-r3
#inherit distutils

DESCRIPTION="A fast NoSQL database on-disk alternative to Redis"
HOMEPAGE="https://github.com/jakeogh/ssdb"
EGIT_REPO_URI="/home/cfg/_myapps/ssdb https://github.com/jakeogh/ssdb.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="dev-libs/leveldb"
