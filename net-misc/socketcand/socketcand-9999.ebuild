# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit git-r3
inherit autotools

DESCRIPTION="socketcand"
HOMEPAGE="https://github.com/dschanoeh/socketcand"

EGIT_REPO_URI="https://github.com/dschanoeh/socketcand.git"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	dev-libs/libconfig
"

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
