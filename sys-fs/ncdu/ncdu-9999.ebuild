# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit git-r3

DESCRIPTION="NCurses Disk Usage"
HOMEPAGE="https://dev.yorhel.nl/ncdu/"
EGIT_REPO_URI="https://g.blicky.net/ncdu.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
	sys-libs/ncurses:0=[unicode]
"

DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_compile() {
	default
}

src_install() {
	dobin ${PN}
}
