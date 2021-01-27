# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#PYTHON_COMPAT=( python3_{8..9} )

inherit autotools git-r3 flag-o-matic

DESCRIPTION="Guile-based library implementing flexible control files for scientific simulations "
HOMEPAGE="https://github.com/NanoComp/libctl"
EGIT_REPO_URI="/home/cfg/_myapps/libctl https://github.com/NanoComp/libctl.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
"

DEPEND="${RDEPEND}"

src_prepare() {
	append-cflags -fPIC || die
	default || die
	./autogen.sh || die
	#autoreconf
	#eautomake
}

src_compile() {
	#econf $(use_enable nls)
	emake || die
}
