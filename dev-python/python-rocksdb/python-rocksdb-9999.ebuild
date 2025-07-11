# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

DESCRIPTION="Python bindings for RocksDB"
HOMEPAGE="https://github.com/jakeogh/python-rocksdb"
EGIT_REPO_URI="/home/sysskel/myapps/python-rocksdb https://github.com/jakeogh/python-rocksdb.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-libs/rocksdb
"

DEPEND="${RDEPEND}"
