# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Operate and manipulate physical quantities in Python"
HOMEPAGE="https://github.com/hgrecco/pint"
EGIT_REPO_URI="https://github.com/hgrecco/pint.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="BSD"

DEPEND=""

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
