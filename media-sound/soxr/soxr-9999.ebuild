# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SoX Resampler library"
HOMEPAGE="https://sourceforge.net/projects/soxr/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/chirlu/soxr.git"
else
	SRC_URI="https://sourceforge.net/projects/soxr/files/${P}-Source.tar.xz"
	S="${WORKDIR}/${P}-Source"
	KEYWORDS="~amd64 ~arm ~arm64 ~loong ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="examples openmp test"
RESTRICT="!test? ( test )"

BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex examples)
		-DBUILD_TESTS=$(usex test)
		-DWITH_OPENMP=$(usex openmp)
		-DWITH_LSR_BINDINGS=OFF
		-DBUILD_SHARED_LIBS=ON
		-DVISIBILITY_HIDDEN=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use examples; then
		dobin "${BUILD_DIR}"/examples/1-*
		dodoc examples/*.c examples/*.cpp
	fi
}
