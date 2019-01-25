# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-r3

DESCRIPTION="small file browser"
HOMEPAGE="http://git.2f30.org/noice/"
EGIT_REPO_URI="git://git.2f30.org/noice/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr/" MANPREFIX="/usr/share/man" install
	dodoc README
}
