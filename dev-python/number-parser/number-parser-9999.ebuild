# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/number-parser"
EGIT_REPO_URI="/home/sysskel/myapps/number-parser https://github.com/jakeogh/number-parser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	
"

DEPEND="${RDEPEND}"


#src_prepare() {
#	default
#	xdg_src_prepare
#}
