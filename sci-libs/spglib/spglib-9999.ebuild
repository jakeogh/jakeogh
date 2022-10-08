# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools eutils versionator git-r3

MY_PV=$(get_version_component_range 1-2 ${PV})

DESCRIPTION="Spglib is a C library for finding and handling crystal symmetries"
HOMEPAGE="http://spglib.sourceforge.net/"
EGIT_REPO_URI="https://github.com/atztogo/spglib.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ase"

RDEPEND="
	ase? ( sci-physics/ase )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --disable-static
}

src_install() {
	default
	prune_libtool_files --all
}
