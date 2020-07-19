# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 eutils toolchain-funcs
#inherit cmake
inherit cmake-multilib

DESCRIPTION="Parser for Schrodinger Maestro files"
HOMEPAGE="https://github.com/schrodinger/maeparser"
EGIT_REPO_URI="/home/cfg/_myapps/maeparser https://github.com/schrodinger/maeparser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND=""

DEPEND="${RDEPEND}"


src_prepare() {
	eapply_user
	#cmake_src_prepare
}

#multilib_src_configure() {
#	local mycmakeargs=(
#		-DLIB_INSTALL_DIR="$(get_libdir)"
#	)
#	cmake_src_configure
#}



src_configure() {
	local libdir="$(get_libdir)"
	mycmakeargs=(
		-DLIBDIR="$(get_libdir)"
		-DLIB_INSTALL_DIR="$(get_libdir)"
	)
	cmake-multilib_src_configure
}
