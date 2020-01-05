# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy{,3} )
PYTHON_REQ_USE="xml(+)"

inherit distutils-r1
inherit mercurial

DESCRIPTION="XML bomb protection for Python stdlib modules, an xml serialiser"
HOMEPAGE="https://bitbucket.org/tiran/defusedxml https://pypi.org/project/defusedxml/"
EHG_REPO_URI="https://bitbucket.org/tiran/defusedxml"

KEYWORDS=""
IUSE="examples"

LICENSE="PSF-2"
SLOT="0"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	esetup.py test
}

python_install_all() {
	use examples && local EXAMPLES=( other/. )
	distutils-r1_python_install_all
}
