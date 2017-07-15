# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="python parser for human readable dates"
HOMEPAGE="https://github.com/scrapinghub/dateparser"
EGIT_REPO_URI="https://github.com/scrapinghub/dateparser.git"
#EGIT_BRANCH="dev"
#EGIT_SUBMODULES=("tests")
#EGIT_SUBMODULES=()

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="doc"
#RESTRICT="test"
DEPEND="dev-python/tzlocal"
RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}

