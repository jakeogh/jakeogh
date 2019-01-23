# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3 savedconfig toolchain-funcs

DESCRIPTION="a simple web browser based on WebKit/GTK+"
HOMEPAGE="http://surf.suckless.org/"
EGIT_REPO_URI="git://git.suckless.org/surf"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="
	dev-libs/glib:2
	net-libs/glib-networking[ssl]
	app-crypt/gcr[gtk]
	net-libs/libsoup
	net-libs/webkit-gtk:4
	x11-libs/gtk+:3
	x11-libs/libX11
"
DEPEND="
	${COMMON_DEPEND}
	virtual/pkgconfig
"
RDEPEND="
	!sci-chemistry/surf
	${COMMON_DEPEND}
	x11-apps/xprop
	>=x11-misc/dmenu-4.7
	!savedconfig? (
		net-misc/curl
		x11-terms/st
	)
"

pkg_setup() {
	if ! use savedconfig; then
		elog "The default config.h assumes you have"
		elog " net-misc/curl"
		elog " x11-terms/st"
		elog "installed to support the download function."
		elog "Without those, downloads will fail (gracefully)."
		elog "You can fix this by:"
		elog "1) Installing these packages, or"
		elog "2) Setting USE=savedconfig and changing config.h accordingly."
	fi
}

src_prepare() {
	default

	restore_config config.h

	tc-export CC PKG_CONFIG

	sed -i '
		s#/usr/local#/usr#
		s# -I${X11INC}# ${X11INC}#
		/X11INC =/c\X11INC = $(shell $(PKG_CONFIG) --cflags x11)
		/X11LIB =/c\X11LIB = $(shell $(PKG_CONFIG) --libs x11)
		/GTKINC =/c\GTKINC = $(shell $(PKG_CONFIG) --cflags gtk+-3.0 gcr-3 gthread-2.0 webkit2gtk-4.0)
		/GTKLIB =/c\GTKLIB = $(shell $(PKG_CONFIG) --libs gtk+-3.0 gcr-3 gthread-2.0 webkit2gtk-4.0)
		/^LIBS =/c\LIBS = ${X11LIB} ${GTKLIB}
	' config.mk
}

src_install() {
	default
	save_config config.h
}
