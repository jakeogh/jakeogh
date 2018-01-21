# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A Python library for working with atoms"
HOMEPAGE="https://gitlab.com/ase/ase"
EGIT_REPO_URI="https://gitlab.com/ase/ase.git"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/numpy
		sci-libs/scipy
		dev-python/matplotlib
		dev-python/flask
		dev-python/pillow"

RDEPEND="${DEPEND}"

#python_install_all() {
#	distutils-r1_python_install_all
#}
