# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="common x11 functions"
HOMEPAGE="https://github.com/jakeogh/x11tool"
EGIT_REPO_URI="/home/cfg/_myapps/x11tool https://github.com/jakeogh/x11tool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	x11-misc/xresqueryclientids
"

DEPEND="${RDEPEND}"
