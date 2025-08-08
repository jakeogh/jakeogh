# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs git-r3

DESCRIPTION="Grep-like tool to search for binary strings"
HOMEPAGE="https://github.com/tmbinc/sbgrep/"
EGIT_REPO_URI="https://github.com/tmbinc/sbgrep"

#S="${WORKDIR}/${MY_P}"
LICENSE="MIT"
SLOT="0"

KEYWORDS=""
IUSE="test"
RDEPEND=""
DEPEND="test? ( dev-lang/perl )"

src_prepare() {
	default
	sed -i -e "s|/tmp/|${T}/|g" \
		test/sbgrep-test.sh || die
}

src_compile() {
	tc-export CC
	emake
}

src_test() {
	cd test || die
	./sbgrep-test.sh || die
}

src_install() {
	dobin sbgrep
	dodoc README
}
