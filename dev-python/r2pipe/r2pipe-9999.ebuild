# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# from https://raw.githubusercontent.com/soltysek/soltys-overlay/master/dev-python/r2pipe/r2pipe-9999.ebuild

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Enable scripting of radare2"
HOMEPAGE="http://rada.re/r/"
EGIT_REPO_URI="https://github.com/radare/radare2-r2pipe.git"

LICENSE="MIT"
SLOT="0"
DEPEND="=dev-util/radare2-9999"

python_compile() {
	cd "$WORKDIR/$P"/python
	distutils-r1_python_compile
}

python_install() {
	cd "$WORKDIR/$P"/python
	distutils-r1_python_install
}
