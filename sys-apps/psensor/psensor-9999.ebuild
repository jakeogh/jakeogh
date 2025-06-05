# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic gnome2-utils xdg-utils git-r3 xdg

DESCRIPTION="A graphical hardware temperature monitor"
HOMEPAGE="http://wpitchoune.net/psensor"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/jeanfi/psensor.git"
	KEYWORDS=""
else
	SRC_URI="http://wpitchoune.net/${PN}/files/${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
	RESTRICT="mirror"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+gtop +hddtemp nls +server udisks X"

BDEPEND="nls? ( sys-devel/gettext )"
RDEPEND="
	dev-libs/json-c
	dev-libs/glib:2
	dev-libs/libatasmart
	gnome-base/dconf
	gtop? ( gnome-base/libgtop:2= )
	hddtemp? ( app-admin/hddtemp )
	net-misc/curl
	server? ( net-libs/libmicrohttpd )
	sys-apps/lm-sensors
	udisks? ( sys-fs/udisks:2 )
	X? (
		x11-libs/gtk+:3
		x11-libs/libnotify
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/cairo
		dev-libs/libappindicator
		gnome-base/dconf
	)"

DEPEND="${RDEPEND}"

#PATCHES=( "${FILESDIR}"/${P}_fix_errors.patch )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	append-cflags '-std=gnu11'
	econf \
		$(use_enable nls) \
		$(use_with gtop) \
		$(use_with X x)
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}
