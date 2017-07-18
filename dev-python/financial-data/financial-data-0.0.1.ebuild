# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )
#PYTHON_COMPAT=( python3_4 )

inherit distutils-r1
inherit git-r3

DESCRIPTION="get financial data from iridb"
HOMEPAGE="https://github.com/jakeogh/financial_data"
EGIT_REPO_URI="/home/cfg/_myapps/financial_data"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/iridb
"

RDEPEND="
	${DEPEND}
"

python_install_all() {
    local DOCS=( README.md )
    distutils-r1_python_install_all
}
