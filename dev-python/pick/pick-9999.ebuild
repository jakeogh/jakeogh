# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="create curses based interactive selection list in the terminal"
HOMEPAGE="https://github.com/wong2/pick"
EGIT_REPO_URI="https://github.com/wong2/pick.git"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"

DEPEND="
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
