# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 toolchain-funcs

DESCRIPTION="simple gopher client"
HOMEPAGE="https://git.fifth.space/sacc/files.html"
EGIT_REPO_URI="git://git.fifth.space/sacc"

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
