# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 flag-o-matic

DESCRIPTION="Guile-based flexible control files for scientific simulations"
HOMEPAGE="https://github.com/NanoComp/libctl"
EGIT_REPO_URI="/home/sysskel/myapps/libctl https://github.com/NanoComp/libctl.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-scheme/guile
"

DEPEND="${RDEPEND}"


src_prepare() {
	append-cflags -fPIC || die
	default
	#./autogen.sh || die
	eautoreconf || die # replaces ./autogen.sh
	#eautomake
}

src_compile() {
	emake || die
}
