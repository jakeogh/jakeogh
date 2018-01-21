# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Python Vehicle Interface Toolkit"
HOMEPAGE="https://github.com/linklayer/pyvit"
EGIT_REPO_URI="https://github.com/jakeogh/pyvit.git"
EGIT_BRANCH="gentoo_compat"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pyserial"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
