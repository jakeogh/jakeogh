# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Thermodynamics, phase equilibria, transport properties and chemical database component of Chemical Engineering Design Library (ChEDL)"
HOMEPAGE="https://github.com/CalebBell/thermo"
EGIT_REPO_URI="https://github.com/CalebBell/thermo.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sci-libs/scipy
	dev-python/pandas
	sci-chemistry/fluids
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
