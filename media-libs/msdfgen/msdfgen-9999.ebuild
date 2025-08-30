# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Multi-channel signed distance field generator (library + CLI)"
HOMEPAGE="https://github.com/Chlumsky/msdfgen"
EGIT_REPO_URI="https://github.com/Chlumsky/msdfgen.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="+cli"

RDEPEND="
	media-libs/freetype:2
	media-libs/libpng:0=
	dev-libs/tinyxml2:=
"
DEPEND="${RDEPEND}"
BDEPEND="dev-build/cmake"

DOCS=( README.md CHANGELOG.md )

src_configure() {
	local mycmakeargs=(
		# Use system deps; do not let it auto-fetch via vcpkg.
		-DMSDFGEN_USE_VCPKG=OFF
		# Explicitly disable Skia (avoids find_package(skia)).
		-DMSDFGEN_USE_SKIA=OFF
		# Provide install targets (CMake option exists upstream).
		-DMSDFGEN_INSTALL=ON
		# Build shared libs.
		-DBUILD_SHARED_LIBS=ON
		# Build the standalone CLI if requested.
		-DMSDFGEN_BUILD_STANDALONE=$(usex cli ON OFF)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	einstalldocs
}

