# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/hpfem/hermes.git"
inherit git-r3
inherit cmake-utils

DESCRIPTION="Library for rapid development of adaptive hp-FEM / hp-DG solvers."
HOMEPAGE="http://www.hpfem.org/hermes/"

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
"

src_prepare() {
	default
	#cp "${WORKDIR}/${P}"/CMake.vars.example.Linux "${WORKDIR}/${P}"/CMake.vars || die
}

