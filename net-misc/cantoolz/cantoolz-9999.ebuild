# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Framework for black-box CAN network analysis"
HOMEPAGE="https://github.com/CANToolz/CANToolz"
EGIT_REPO_URI="https://github.com/CANToolz/CANToolz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/pyserial
	media-sound/mido
	dev-python/numpy
	dev-python/bitstring
	dev-python/pip
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
