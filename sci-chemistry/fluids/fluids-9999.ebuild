# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Fluid dynamics component of Chemical Engineering Design Library (ChEDL)"
HOMEPAGE="https://github.com/CalebBell/fluids"
EGIT_REPO_URI="https://github.com/CalebBell/fluids.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sci-libs/scipy
	dev-python/numpy
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
