# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Library for rapid development of adaptive hp-FEM / hp-DG solvers."
HOMEPAGE="http://www.hpfem.org/hermes/"
EGIT_REPO_URI="https://github.com/hpfem/hermes.git"
inherit git-r3
inherit cmake

#S="${WORKDIR}/${P}/hermes2d"

LICENSE="LGPL"
SLOT=0

DEPEND="
	media-libs/freeglut
	sci-libs/suitesparse
	media-libs/glew
	dev-libs/xerces-c
	dev-cpp/xsd
	sci-libs/matio
	dev-java/xsdlib
	sci-libs/exodusii
	sci-libs/clapack
	 sci-libs/umfpack
"

src_prepare() {
	default
	cmake-utils_src_prepare
	cp "${WORKDIR}/${P}"/CMake.vars.example.Linux "${WORKDIR}/${P}"/CMake.vars || die
	sed -i '
s#/usr/local#/usr#
' "${WORKDIR}/${P}"/CMake.vars || die
}

src_configure() {
	local CMAKE_BUILD_TYPE="Release"
	local mycmakeargs=(
			-DCMAKE_INSTALL_PREFIX=/usr
			)
	cmake-utils_src_configure
}


