# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs
inherit cmake-multilib

CMAKE_ECLASS="cmake-utils"
DESCRIPTION="Schrodinger, Inc's 2D coordinate generation"
HOMEPAGE="https://github.com/schrodinger/coordgenlibs"
EGIT_REPO_URI="https://github.com/schrodinger/coordgenlibs.git"

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
	insinto /usr/lib64/
	use maeparser && doins templates.mae
}
