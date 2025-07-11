# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs
inherit git-r3

DESCRIPTION="Hash-based file manager."
EGIT_REPO_URI="https://github.com/jakeogh/crandompipe.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="
	dev-lang/zig
"

RDEPEND=""

src_prepare() {
	default
	sed -i -e "s|/tmp/|${T}/|g" \
		test/crandompipe-test.sh || die
}

src_compile() {
	tc-export CC
	emake
}

src_test() {
	cd test || die
	./crandompipe-test.sh || die
}

src_install() {
	dobin crandompipe
}
