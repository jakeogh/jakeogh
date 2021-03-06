# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit savedconfig toolchain-funcs git-r3

DESCRIPTION="Simple generic tabbed fronted to xembed aware applications."
HOMEPAGE="http://tools.suckless.org/tabbed"
EGIT_REPO_URI="http://git.suckless.org/tabbed"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="
	x11-base/xorg-proto
	${RDEPEND}
"

src_prepare() {
	sed config.mk \
		-e '/^CC/d' \
		-e 's|/usr/local|/usr|g' \
		-e 's|^CFLAGS.*|CFLAGS += -std=c99 -pedantic -Wall $(INCS) $(CPPFLAGS)|g' \
		-e 's|^LDFLAGS.*|LDFLAGS += $(CFLAGS) $(LIBS)|g' \
		-e 's|^LIBS.*|LIBS = -lX11 $(FREETYPELIBS)|g' \
		-e 's|{|(|g;s|}|)|g' \
		-i || die

	sed Makefile \
		-e 's|{|(|g;s|}|)|g' \
		-e '/^[[:space:]]*@echo/d' \
		-e 's|^	@|	|g' \
		-i || die

	restore_config config.h
}

src_compile() {
	emake CC=$(tc-getCC)
}
src_install() {
	default
	save_config config.h
}
