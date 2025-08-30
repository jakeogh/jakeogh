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
    -DMSDF_ATLAS_GEN_BUILD_STANDALONE=OFF
    -DMSDF_ATLAS_GEN_USE_VCPKG=OFF
    -DMSDF_ATLAS_GEN_USE_SKIA=OFF
    -DMSDFGEN_USE_SKIA=OFF
    -DMSDFGEN_USE_VCPKG=OFF
    -DMSDFGEN_BUILD_STANDALONE=OFF

    # <<< hard block any Skia lookup >>>
    -DCMAKE_DISABLE_FIND_PACKAGE_unofficial-skia=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Skia=ON
  )
  cmake_src_configure
}

src_install() {
	cmake_src_install
	# Upstream installs headers under include/msdf-atlas-gen and exports
	# CMake target: msdf-atlas-gen::msdf-atlas-gen
}


