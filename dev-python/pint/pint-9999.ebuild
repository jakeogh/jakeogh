# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Operate and manipulate physical quantities in Python"
HOMEPAGE="https://github.com/hgrecco/pint"
EGIT_REPO_URI="https://github.com/hgrecco/pint.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""
LICENSE="BSD"

DEPEND=""

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
