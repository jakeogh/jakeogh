# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial toolchain-funcs

DESCRIPTION="dmenu spinoff for the console"
HOMEPAGE="https://bitbucket.org/rafaelgg/slmenu"
EHG_REPO_URI="https://bitbucket.org/rafaelgg/slmenu"

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
	#emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	emake install
}

