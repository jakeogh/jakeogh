# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A friendly car security exploration tool"
HOMEPAGE="https://github.com/CaringCaribou/caringcaribou"
EGIT_REPO_URI="https://github.com/CaringCaribou/caringcaribou.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/python-can
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
