# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 git-r3

DESCRIPTION="libpcap cli wrapper"
HOMEPAGE="https://github.com/jakeogh/pyethercap"
EGIT_REPO_URI="/home/sysskel/myapps/pyethercap https://github.com/jakeogh/pyethercap.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/python-libpcap[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
