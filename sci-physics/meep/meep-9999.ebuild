# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 flag-o-matic

DESCRIPTION="finite-difference time-domain (FDTD) software for electromagnetic simulations"
HOMEPAGE="https://github.com/NanoComp/meep"
EGIT_REPO_URI="https://github.com/NanoComp/meep.git"

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
	default
	#./autogen.sh || die
	eautoreconf || die
	#eautomake
}

src_configure() {
	local myeconfargs=("--enable-maintainer-mode")
	econf "${myeconfargs[@]}"
}

src_compile() {
	#econf $(use_enable nls)
	emake
}
