# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="Properties of elements, ions and isotopes in the periodic table of elements"
HOMEPAGE="https://github.com/lmmentel/mendeleev"
EGIT_REPO_URI="/home/sysskel/myapps/mendeleev https://github.com/lmmentel/mendeleev.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="plot"

DEPEND="
	dev-python/pyfiglet[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"

RDEPEND="
	${DEPEND}
	plot? ( dev-python/bokeh[${PYTHON_USEDEP}] )
"

#python_install_all() {
#	distutils-r1_python_install_all
#}
