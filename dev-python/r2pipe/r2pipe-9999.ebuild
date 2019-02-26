# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# from https://raw.githubusercontent.com/soltysek/soltys-overlay/master/dev-python/r2pipe/r2pipe-9999.ebuild

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )

inherit distutils-r1 git-r3

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
