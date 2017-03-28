# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Framework for black-box CAN network analysis"
HOMEPAGE="https://github.com/eik00d/CANToolz"
EGIT_REPO_URI="https://github.com/eik00d/CANToolz.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/pyserial
	media-sound/mido
	dev-python/numpy
	dev-python/bitstring
"

RDEPEND="${DEPEND}"

python_install_all() {
        distutils-r1_python_install_all
}

#        local DOCS=( README.md )
