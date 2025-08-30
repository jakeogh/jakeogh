# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit cmake git-r3

DESCRIPTION="Multi-channel signed distance field atlas generator library (live git)"
HOMEPAGE="https://github.com/Chlumsky/msdf-atlas-gen"
EGIT_REPO_URI="https://github.com/Chlumsky/msdf-atlas-gen.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="cli"

# Upstream uses msdfgen; headers & libs come from media-libs/msdfgen.
RDEPEND="
	media-libs/msdfgen
	media-libs/libpng:0=
	sys-libs/zlib
	dev-libs/tinyxml2
	media-libs/freetype:2
"
DEPEND="${RDEPEND}"
BDEPEND="dev-build/cmake"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON

		# Build the library only (CLI optional via USE 'cli')
		-DMSDF_ATLAS_GEN_BUILD_STANDALONE=$(usex cli ON OFF)

		# Never pull dependencies via vcpkg/FetchContent
		-DMSDF_ATLAS_GEN_USE_VCPKG=OFF

		# Make absolutely sure Skia is disabled in BOTH layers
		# (top-level and the embedded msdfgen subdir).
		-DMSDF_ATLAS_GEN_USE_SKIA=OFF
		-DMSDFGEN_USE_SKIA=OFF

		# Also keep msdfgen’s own network helpers off just in case
		-DMSDFGEN_USE_VCPKG=OFF
		-DMSDFGEN_BUILD_STANDALONE=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	# Upstream installs headers under include/msdf-atlas-gen and exports
	# CMake target: msdf-atlas-gen::msdf-atlas-gen
}


