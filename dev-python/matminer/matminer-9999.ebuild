# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="data mining for Materials Science"
HOMEPAGE="https://hackingmaterials.github.io/matminer/"
EGIT_REPO_URI="https://github.com/hackingmaterials/matminer.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pymatgen
		dev-python/tqdm
		dev-python/pandas
		dev-python/pymongo
		sci-BIOC/pint
		dev-python/six
		dev-python/citrination-client
		dev-python/plotly
		dev-python/matplotlib
		dev-python/jmespath
		dev-python/ujson
		dev-python/httplib2
		sci-physics/ase
		dev-python/pycookiecheat"

RDEPEND="${DEPEND}"

python_install_all() {
        distutils-r1_python_install_all
}


#        local DOCS=( README.md )
