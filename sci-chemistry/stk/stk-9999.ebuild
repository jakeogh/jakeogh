# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_6,3_7} )

inherit distutils-r1

DESCRIPTION="A Python library for building, manipulating, analyzing and automatic design of molecules."
HOMEPAGE="https://github.com/lukasturcani/stk"
EGIT_REPO_URI="https://github.com/lukasturcani/stk.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/networkx
	sci-libs/scipy
	dev-python/matplotlib
	dev-python/psutil
	sci-chemistry/pywindow
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
