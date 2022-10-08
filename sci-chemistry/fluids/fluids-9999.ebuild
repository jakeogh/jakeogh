# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Fluid dynamics component of Chemical Engineering Design Library (ChEDL)"
HOMEPAGE="https://github.com/CalebBell/fluids"
EGIT_REPO_URI="https://github.com/CalebBell/fluids.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	sci-libs/scipy[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
