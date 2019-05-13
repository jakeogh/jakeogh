# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="robust, optimal, and maintainable programming language"
HOMEPAGE="https://ziglang.org"
EGIT_REPO_URI="https://github.com/ziglang/zig"
inherit git-r3
inherit cmake-utils
inherit llvm

#S="${WORKDIR}/${P}/hermes2d"

LICENSE="MIT"
SLOT=0

LLVM_MAX_SLOT=8

DEPEND="
	sys-devel/clang
"

src_prepare() {
	default
	cmake-utils_src_prepare
#	cp "${WORKDIR}/${P}"/CMake.vars.example.Linux "${WORKDIR}/${P}"/CMake.vars || die
#	sed -i '
#s#/usr/local#/usr#
#' "${WORKDIR}/${P}"/CMake.vars || die
}

src_configure() {
#	local CMAKE_BUILD_TYPE="Release"
	local mycmakeargs=(
			-DCMAKE_INSTALL_PREFIX=/usr
			)
	cmake-utils_src_configure
}


