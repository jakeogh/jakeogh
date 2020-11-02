# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs
inherit git-r3

DESCRIPTION="Hash-based file manager."
EGIT_REPO_URI="/home/user/_myapps/uhashfsc/"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

#DEPEND="
#	dev-util/cwalk
#"

RDEPEND=""

src_prepare() {
	default
	sed -i -e "s|/tmp/|${T}/|g" \
		test/uhashfsc-test.sh || die
}

src_compile() {
	tc-export CC
	emake
}

src_test() {
	cd test || die
	./uhashfsc-test.sh || die
}

src_install() {
	dobin uhashfsc
	dobin uhashfsc_nocheck
	dodoc README
}
