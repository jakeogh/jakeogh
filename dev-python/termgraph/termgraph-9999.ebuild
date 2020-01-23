# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Tool which draws basic graphs in the terminal"
HOMEPAGE="https://github.com/mkaz/termgraph"
EGIT_REPO_URI="https://github.com/mkaz/termgraph"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
