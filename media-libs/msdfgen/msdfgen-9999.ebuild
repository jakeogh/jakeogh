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

# Upstream splits "core" (header-only/no deps) vs "extensions" + CLI that need these.
# We always build the extensions/CLI by default to provide a useful tool.
# If you set USE=-cli, we still build the library, just skip the standalone binary.
RDEPEND="
	media-libs/freetype:2
	media-libs/libpng:0=
	dev-libs/tinyxml2:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"

DOCS=( README.md CHANGELOG.md )

src_configure() {
	local mycmakeargs=(
		# Do not use vcpkg; rely on system packages.
		-DMSDFGEN_USE_VCPKG=OFF
		# Build/install shared libs.
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

