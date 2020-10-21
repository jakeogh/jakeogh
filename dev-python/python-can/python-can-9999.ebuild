# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="The can package provides controller area network support for Python developers"
HOMEPAGE="https://github.com/hardbyte/python-can"
EGIT_REPO_URI="/home/cfg/_myapps/python-can https://github.com/hardbyte/python-can.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
DEPEND=""
RDEPEND="${DEPEND}"
RESTRICT="test"

python_install_all() {
	#mv "${D}/usr/bin/canplayer" "${D}/usr/bin/canplayer-py" || die
	rm -rf "${S}/test" || die
	distutils-r1_python_install_all
}
