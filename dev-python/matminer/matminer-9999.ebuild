# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="data mining for Materials Science"
HOMEPAGE="https://hackingmaterials.github.io/matminer/"
EGIT_REPO_URI="https://github.com/hackingmaterials/matminer.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""
LICENSE="BSD"

DEPEND="dev-python/pymatgen[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/pint[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/citrination-client[${PYTHON_USEDEP}]
	dev-python/plotly[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	sci-physics/ase[${PYTHON_USEDEP}]
	dev-python/pycookiecheat[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
