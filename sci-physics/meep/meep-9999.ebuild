# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 flag-o-matic

DESCRIPTION="finite-difference time-domain (FDTD) software for electromagnetic simulations"
HOMEPAGE="https://github.com/NanoComp/meep"
EGIT_REPO_URI="/home/cfg/_myapps/meep https://github.com/NanoComp/meep.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	sci-libs/libctl
"

DEPEND="${RDEPEND}"

src_prepare() {
	append-cflags -fPIC || die
	append-cflags --with-maintainer-mode || die
	default
	./autogen.sh || die
	#autoreconf
	#eautomake
}

src_configure() {
	myeconfargs=("--enable-maintainer-mode")
	autotools_src_configure
}

src_compile() {
	#econf $(use_enable nls)
	emake
}
