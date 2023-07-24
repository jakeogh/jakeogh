# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="Common functions for working with IRI's and URI's"
HOMEPAGE="https://github.com/jakeogh/iritool"
EGIT_REPO_URI="/home/sysskel/myapps/iritool https://github.com/jakeogh/iritool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
"

DEPEND="${RDEPEND}"
