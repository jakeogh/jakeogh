# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

DISTUTILS_USE_PEP517="poetry"
inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="Python3.8+ process launching"
HOMEPAGE="https://github.com/jakeogh/sh"
EGIT_REPO_URI="/home/cfg/_myapps/sh https://github.com/jakeogh/sh.git"
#EGIT_BRANCH="fd_control"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
"

DEPEND="${RDEPEND}"
