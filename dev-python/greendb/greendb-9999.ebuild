# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

DESCRIPTION="server frontend for lmdb"
HOMEPAGE="https://github.com/jakeogh/greendb"
EGIT_REPO_URI="https://github.com/jakeogh/greendb.git"
#EGIT_BRANCH="master"
GIT_BRANCH="jkdev"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/lmdb[${PYTHON_USEDEP}]
	dev-python/gevent[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]
	dev-python/setproctitle[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
