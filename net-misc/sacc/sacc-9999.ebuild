# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 savedconfig toolchain-funcs

DESCRIPTION="simple gopher client"
HOMEPAGE="https://git.fifth.space/sacc/files.html"
EGIT_REPO_URI="git://git.fifth.space/sacc"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="
	sys-libs/ncurses:0=
	${RDEPEND}"

PATCHES=()

src_prepare() {
	 sed config.mk \
  -e '/^CC/d' \
  -e 's|/usr/local|/usr|g' \
  -e 's|{|(|g;s|}|)|g' \
  -i || die

 sed Makefile \
  -e 's|{|(|g;s|}|)|g' \
  -e '/^[[:space:]]*@echo/d' \
  -e 's|^ @| |g' \
  -e 's|chmod 555|chmod 755|g' \
  -i || die

	restore_config config.h
	eapply_user
	#tc-export CC PKG_CONFIG
}

src_compile() {
	 emake \
	CC=$(tc-getCC) \
	LIBS="$(pkg-config --libs ncurses)"
}

src_install() {
	default
	save_config config.h
	#emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	#emake install
}
