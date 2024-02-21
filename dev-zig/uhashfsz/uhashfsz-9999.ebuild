# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3


DESCRIPTION="content addressed fs tree lookup"
HOMEPAGE="https://github.com/jakeogh/uhashfsz"
EGIT_REPO_URI="/home/sysskel/myapps/uhashfsz https://github.com/jakeogh/uhashfsz.git"

MY_P="${P/-/_}"
MY_PN="${PN/-/_}"
#MY_S=""${WORKDIR}/${MY_P}""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND=""

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
	dobin uhashfsz/uhashfsz
	#dosym "/usr/bin/${PN}" "/usr/bin/${PN}-print-missing"
}
