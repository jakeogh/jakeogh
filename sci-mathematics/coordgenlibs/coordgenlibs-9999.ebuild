# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 eutils toolchain-funcs
inherit cmake-multilib

CMAKE_ECLASS="cmake-utils"
DESCRIPTION="Schrodinger, Inc's 2D coordinate generation"
HOMEPAGE="https://github.com/schrodinger/coordgenlibs"
#EGIT_REPO_URI="/home/cfg/_myapps/maeparser https://github.com/schrodinger/maeparser.git"
EGIT_REPO_URI="https://github.com/schrodinger/coordgenlibs.git"
#EGIT_BRANCH="patch-1"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="+maeparser"

RDEPEND=""

DEPEND="${RDEPEND}
	maeparser? ( sci-chemistry/maeparser )"

src_prepare() {
	eapply_user
	cmake-utils_src_prepare
}

src_configure() {
	local libdir="$(get_libdir)"
	mycmakeargs=(
		-DLIBDIR="$(get_libdir)"
		-DLIB_INSTALL_DIR="$(get_libdir)"
		-DCOORDGEN_USE_MAEPARSER=$(usex maeparser)
	)
	cmake-multilib_src_configure --libdir=/usr/$(get_libdir)
}

src_compile() {
	cmake-multilib_src_compile
}

src_install() {
	cmake-multilib_src_install
	insinto /usr/include/coordgen/
	use maeparser && doins templates.mae
}
