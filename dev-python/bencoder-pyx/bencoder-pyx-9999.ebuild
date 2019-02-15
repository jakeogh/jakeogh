# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A fast bencode implementation in Cython"
HOMEPAGE="https://github.com/whtsky/bencoder.pyx"
EGIT_REPO_URI="https://github.com/whtsky/bencoder.pyx.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
"

RDEPEND="${DEPEND}"

#python_install_all() {
#	distutils-r1_python_install_all
#}

