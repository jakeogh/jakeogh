# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A Python module to help you manage your bits"
HOMEPAGE="https://github.com/scott-griffiths/bitstring"
EGIT_REPO_URI="https://github.com/scott-griffiths/bitstring.git"

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
