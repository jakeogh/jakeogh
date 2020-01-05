# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Extensible periodic table for python."
HOMEPAGE="http://www.reflectometry.org/danse/elements.html"
EGIT_REPO_URI="https://github.com/pkienzle/periodictable.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="PublicDomain"

DEPEND="dev-python/numpy
		dev-python/pyparsing"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
