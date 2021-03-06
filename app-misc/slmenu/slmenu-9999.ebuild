# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 toolchain-funcs

DESCRIPTION="dmenu spinoff for the console"
HOMEPAGE="https://github.com/joshaw/slmenu"
EGIT_REPO_URI="/home/user/_myapps/slmenu https://github.com/jakeogh/slmenu"

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
