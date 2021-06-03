# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Extensible periodic table for python."
HOMEPAGE="http://www.reflectometry.org/danse/elements.html"
EGIT_REPO_URI="https://github.com/pkienzle/periodictable.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""
LICENSE="PublicDomain"

DEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
