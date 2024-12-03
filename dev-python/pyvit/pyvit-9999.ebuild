# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{11..13} )

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
