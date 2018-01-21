# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit git-r3
inherit autotools

DESCRIPTION="Linux-CAN / SocketCAN user space applications"
HOMEPAGE="https://github.com/linux-can/can-utils"

EGIT_REPO_URI="https://github.com/linux-can/can-utils.git"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_prepare() {
	eapply_user
	eautoreconf --force --install
}

src_compile() {
	emake || die "Compile failed."
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die "Install failed."
}
