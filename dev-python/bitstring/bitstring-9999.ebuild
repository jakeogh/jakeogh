# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3


DESCRIPTION="A Python module to help you manage your bits"
HOMEPAGE="https://github.com/scott-griffiths/bitstring"
EGIT_REPO_URI="https://github.com/scott-griffiths/bitstring.git"

DISTUTILS_USE_PEP517="setuptools"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
