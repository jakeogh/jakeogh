# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="structural analysis of discrete molecules"
HOMEPAGE="https://github.com/marcinmiklitz/pywindow"
EGIT_REPO_URI="https://github.com/marcinmiklitz/pywindow.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
