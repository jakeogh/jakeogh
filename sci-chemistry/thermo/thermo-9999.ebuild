# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Thermodynamics, phase equilibria, transport properties and chemical database component of Chemical Engineering Design Library (ChEDL)"
HOMEPAGE="https://github.com/CalebBell/thermo"
EGIT_REPO_URI="https://github.com/CalebBell/thermo.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	sci-libs/scipy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	sci-chemistry/fluids[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
