# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="library for materials analysis"
HOMEPAGE="https://github.com/materialsproject/pymatgen"
EGIT_REPO_URI="https://github.com/materialsproject/pymatgen.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/monty[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	dev-python/pydispatcher[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	sci-libs/spglib
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/palettable[${PYTHON_USEDEP}]
	dev-python/simpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/pybtex[${PYTHON_USEDEP}]
	sci-physics/ase
	sci-libs/vtk
	dev-python/APScheduler[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
