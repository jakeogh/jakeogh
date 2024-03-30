# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3


#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="A FUSE based file system in zig"
HOMEPAGE="https://github.com/Sekky61/etiketa"
EGIT_REPO_URI="/home/sysskel/myapps/etiketa https://github.com/Sekky61/etiketa.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}
#

src_compile() {
        #zig build-exe ${PN}.zig --strip || die
        echo ${S}/${MY_PN}/${MY_PN}.zig
        pwd
        cd uhashfsz
        pwd
        #zig build-exe ${S}/${MY_PN}/${MY_PN}.zig --strip || die
        zig build-exe ${S}/${MY_PN}/${MY_PN}.zig --verbose-link -O Debug || die
}

src_install() {
        dobin "${PN}/${PN}"
        #dosym "/usr/bin/${PN}" "/usr/bin/${PN}-print-missing"
}

