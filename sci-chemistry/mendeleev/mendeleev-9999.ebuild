# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_6,3_7} )

inherit distutils-r1

DESCRIPTION="properties of elements, ions and isotopes in the periodic table of elements"
HOMEPAGE="https://bitbucket.org/lukaszmentel/mendeleev"
EHG_REPO_URI="https://bitbucket.org/lukaszmentel/mendeleev"
inherit mercurial

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="plot"

DEPEND="
	dev-python/pyfiglet
	dev-python/colorama
	dev-python/sqlalchemy
	dev-python/pandas
	dev-python/numpy
"

RDEPEND="
	${DEPEND}
	plot? ( dev-python/bokeh )
"

python_install_all() {
	distutils-r1_python_install_all
}
