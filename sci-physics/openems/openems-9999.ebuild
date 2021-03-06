# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3 cmake

DESCRIPTION="Electromagnetic field solver using the FDTD method"
HOMEPAGE="https://github.com/thliebig/openEMS-Project"
EGIT_REPO_URI="/home/cfg/_myapps/openems https://github.com/thliebig/openEMS-Project.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-util/ninja
	dev-libs/tinyxml
	sci-mathematics/cgal
	sci-libs/vtk[qt5]
"

DEPEND="${RDEPEND}"

#src_prepare() {
#	sed -i 's/EQUAL 6/EQUAL 8/' "${S}/openEMS/CMakeLists.txt" || die
#	eapply_user
#}

src_configure() {
	local CMAKE_BUILD_TYPE="Release"
	mycmakeargs=(
	-DCMAKE_INSTALL_PREFIX="${D}"
	)
	cmake_src_configure
}
