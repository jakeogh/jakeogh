# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs
inherit cmake

CMAKE_ECLASS="cmake-utils"
DESCRIPTION="Parser for Schrodinger Maestro files"
HOMEPAGE="https://github.com/schrodinger/maeparser"
#EGIT_REPO_URI="/home/sysskel/myapps/maeparser https://github.com/schrodinger/maeparser.git"
#EGIT_REPO_URI="https://github.com/Peter-Levine/maeparser.git"
EGIT_REPO_URI="https://github.com/schrodinger/maeparser.git"
#EGIT_BRANCH="patch-1"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND=""

DEPEND="${RDEPEND}"

src_prepare() {
	eapply_user
	cmake_src_prepare
}

src_configure() {
	local libdir="$(get_libdir)"
	mycmakeargs=(
		-DLIBDIR="$(get_libdir)"
		-DLIB_INSTALL_DIR="$(get_libdir)"
	)
	#cmake-multilib_src_configure --libdir=/usr/$(get_libdir)
	cmake_src_configure --libdir=/usr/$(get_libdir)
}

src_compile() {
	#cmake-multilib_src_compile
	cmake_src_compile
}

src_install() {
	#cmake-multilib_src_install
	cmake_src_install
}
