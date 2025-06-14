# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 savedconfig toolchain-funcs desktop xdg

DESCRIPTION="a simple web browser based on WebKit/GTK+"
HOMEPAGE="https://surf.suckless.org/"
EGIT_REPO_URI="/home/user/_myapps/surf-persistent"
EGIT_BRANCH="surf-webkit2"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="firejail"

SPN="surf"

#SS="${WORKDIR}/${P}"

COMMON_DEPEND="
	firejail? (
		sys-apps/firejail
	)
	app-crypt/gcr[gtk]
	dev-libs/glib:2
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
	>=x11-misc/dmenu-4.7
	net-misc/curl
	x11-apps/xprop
	x11-terms/st
"
PATCHES=(
	"${FILESDIR}"/${PN}-9999-gentoo.patch
)

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
}

src_install() {
	mkdir -p "${D}/usr/bin"
	cp "${S}/${SPN}" "${D}/usr/bin/surf-persistent" || die
	#default
	save_config config.h
	#newicon "${S}"/"${SPN}".png "${PN}".png

	#local mime_types="text/html;text/xml;application/xhtml+xml;"
	#mime_types+="x-scheme-handler/http;x-scheme-handler/https;"
	#make_desktop_entry \
	#	"surf-persistent" \
	#	"Surf-Persistent" \
	#	"surf-persistent" \
	#	"Network;WebBrowser" \
	#	"MimeType=${mime_types}\nStartupWMClass=surf-persistent" || die
}

#pkg_postinst() {
#	xdg_desktop_database_update
#	xdg_icon_cache_update
#}
#
#pkg_postrm() {
#	xdg_desktop_database_update
#	xdg_icon_cache_update
#}
