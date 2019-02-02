# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit git-r3

DESCRIPTION="Colourful visualization tool for binary files"
HOMEPAGE="https://github.com/FireyFly/pixd"
EGIT_REPO_URI="https://github.com/FireyFly/pixd.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND=""
DEPEND="${RDEPEND}"


#src_install() {
#	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr/" MANPREFIX="/usr/share/man" install
#	dodoc README
#}
