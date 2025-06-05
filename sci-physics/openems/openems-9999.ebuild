# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
#PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3 cmake

DESCRIPTION="Electromagnetic field solver using the FDTD method"
HOMEPAGE="https://github.com/thliebig/openEMS-Project"
EGIT_REPO_URI="https://github.com/thliebig/openEMS-Project.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="hyp2mat ctb +gui mpi"

RDEPEND="
	dev-util/ninja
	dev-libs/tinyxml
	sci-mathematics/cgal
	sci-libs/vtk[qt5]
"

DEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs=(
		-DBUILD_APPCSXCAD=$(usex gui)
		-DWITH_MPI=$(usex mpi)
	)
	cmake_src_configure
}
