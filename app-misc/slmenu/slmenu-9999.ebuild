# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="dmenu spinoff for the console"
HOMEPAGE="https://github.com/joshaw/slmenu"
EGIT_REPO_URI="https://github.com/jakeogh/slmenu.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
PATCHES=()

src_prepare() {
	default
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	#emake install
}
