# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="The can package provides controller area network support for Python developers"
HOMEPAGE="https://github.com/hardbyte/python-can"
EGIT_REPO_URI="https://github.com/hardbyte/python-can.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

python_install_all() {
	mv "${D}/usr/bin/canplayer" "${D}/usr/bin/canplayer-py" || die
	distutils-r1_python_install_all
}
