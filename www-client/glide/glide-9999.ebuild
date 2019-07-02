# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3 savedconfig toolchain-funcs desktop xdg

DESCRIPTION="a simple web browser based on surf from suckless.org"
HOMEPAGE="http://surf.suckless.org/"
EGIT_REPO_URI="/home/cfg/_myapps/glide/glide"
EGIT_BRANCH="glide"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="X tabbed"

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
	tabbed? ( >=x11-misc/tabbed-0.6 )
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
		/^X11INC =/c\X11INC = $(shell $(PKG_CONFIG) --cflags x11)
		/^X11LIB =/c\X11LIB = $(shell $(PKG_CONFIG) --libs x11)
		/^GTKINC =/c\GTKINC = $(shell $(PKG_CONFIG) --cflags gtk+-3.0 gcr-3 gthread-2.0 webkit2gtk-4.0)
		/^GTKLIB =/c\GTKLIB = $(shell $(PKG_CONFIG) --libs gtk+-3.0 gcr-3 gthread-2.0 webkit2gtk-4.0)
		/^WEBEXTINC =/c\WEBEXTINC = $(shell $(PKG_CONFIG) --cflags webkit2gtk-4.0 webkit2gtk-web-extension-4.0)
		/^WEBEXTLIBS =/c\WEBEXTLIBS = $(shell $(PKG_CONFIG) --libs webkit2gtk-4.0 webkit2gtk-web-extension-4.0)
		/^LIBS =/c\LIBS = $(X11LIB) $(GTKLIB)
	' config.mk

	sed -i '
		/^WEBEXTSRC =/c\WEBEXTSRC = libglide-webext.c common.c
		/^	$(CC) -shared -Wl,-soname,$@ $(LDFLAGS) -o $@ $< $(WEBEXTLIBS) -lc/c\	$(CC) -shared -Wl,-soname,$@ common.o $(LDFLAGS) -o $@ $< $(WEBEXTLIBS) -lc
	' Makefile

	sed -i '
		s#tabbed -dn tabbed-glide -r 2 glide#tabbed -k -dn tabbed-glide -r 2 glide#
	' glide-open.sh
}

src_install() {
	default
	save_config config.h
	if use tabbed; then
		dobin glide-open.sh
	fi
	if use X; then
		local mime_types="text/html;text/xml;application/xhtml+xml;"
		mime_types+="x-scheme-handler/http;x-scheme-handler/https;" # bug #360797
		mime_types+="x-scheme-handler/ftp;" # bug #412185
		mime_types+="x-scheme-handler/mailto;x-scheme-handler/webcal;" # bug #416393
		make_desktop_entry \
			glide -S \
			"Glide" \
			glide \
			"Network;WebBrowser" \
			"MimeType=${mime_types}\nStartupWMClass=glide" || die
	fi
}
