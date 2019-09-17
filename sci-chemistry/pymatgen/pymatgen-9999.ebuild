# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="library for materials analysis"
HOMEPAGE="https://github.com/materialsproject/pymatgen"
EGIT_REPO_URI="https://github.com/materialsproject/pymatgen.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/numpy
		dev-python/six
		dev-python/requests
		dev-python/ruamel-yaml
		dev-python/monty
		sci-libs/scipy
		dev-python/pydispatcher
		dev-python/tabulate
		sci-libs/spglib
		dev-python/matplotlib
		dev-python/palettable
		dev-python/simpy
		dev-python/pandas
		dev-python/pybtex
		sci-physics/ase
		sci-libs/vtk
		dev-python/APScheduler"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
