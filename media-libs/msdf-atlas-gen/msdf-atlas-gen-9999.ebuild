


EAPI=8
inherit cmake git-r3

DESCRIPTION="Multi-channel signed distance field atlas generator (live git)"
HOMEPAGE="https://github.com/Chlumsky/msdf-atlas-gen"
EGIT_REPO_URI="https://github.com/Chlumsky/msdf-atlas-gen.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="cli"

RDEPEND="
  media-libs/msdfgen
  media-libs/libpng:0=
  sys-libs/zlib
  dev-libs/tinyxml2
  media-libs/freetype:2
"
DEPEND="${RDEPEND}"
BDEPEND="dev-build/cmake"

src_prepare() {
  cmake_src_prepare
  # Upstream’s embedded msdfgen unconditionally does: find_package(unofficial-skia REQUIRED)
  # Make it non-fatal so we can build without Skia.
  sed -i \
    -e 's/find_package( *unofficial-skia *REQUIRED *\))/find_package(unofficial-skia QUIET))/Ig' \
    -e 's/find_package( *Skia *REQUIRED *\))/find_package(Skia QUIET))/Ig' \
    msdfgen/CMakeLists.txt || die "sed Skia REQUIRED→QUIET failed"
}

src_configure() {
  local mycmakeargs=(
    -DBUILD_SHARED_LIBS=ON
    -DMSDF_ATLAS_GEN_BUILD_STANDALONE=$(usex cli ON OFF)
    -DMSDF_ATLAS_GEN_USE_VCPKG=OFF
    -DMSDF_ATLAS_GEN_USE_SKIA=OFF

    # Make sure the embedded msdfgen never tries to wire Skia
    -DMSDFGEN_USE_SKIA=OFF
    -DMSDFGEN_USE_VCPKG=OFF
    -DMSDFGEN_BUILD_STANDALONE=OFF

    # Belt-and-suspenders, but harmless after the sed:
    -DCMAKE_DISABLE_FIND_PACKAGE_unofficial-skia=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Skia=ON
  )
  cmake_src_configure
}

