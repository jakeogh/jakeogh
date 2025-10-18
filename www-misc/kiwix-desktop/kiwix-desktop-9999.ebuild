# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg-utils git-r3

DESCRIPTION="Kiwix offline reader for Web content (Wikipedia and more)"
HOMEPAGE="https://www.kiwix.org/ https://github.com/kiwix/kiwix-desktop"
EGIT_REPO_URI="https://github.com/kiwix/kiwix-desktop.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-qt/qtbase:6[gui,network,widgets]
	dev-qt/qtwebengine:6
	dev-qt/qtsvg:6
	dev-libs/kiwix-lib
	net-misc/aria2
"

DEPEND="
	${RDEPEND}
	dev-qt/qttools:6[linguist]
"

BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	eqmake6 PREFIX="${EPREFIX}/usr" kiwix-desktop.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs

	# Ensure binary is executable
	fperms +x /usr/bin/kiwix-desktop || die "Binary not found"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
