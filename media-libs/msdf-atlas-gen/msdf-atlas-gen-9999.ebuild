


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

  # Make Skia optional/quiet and OFF, and never define the macro
  sed -i \
    -e 's/find_package( *unofficial-skia\>[^)]*)/find_package(unofficial-skia QUIET)/Ig' \
    -e 's/find_package( *Skia\>[^)]*)/find_package(Skia QUIET)/Ig' \
    -e 's/^[[:space:]]*option[[:space:]]*( *MSDFGEN_USE_SKIA[^)]*)/option(MSDFGEN_USE_SKIA "Use Skia" OFF)/I' \
    -e 's/^[[:space:]]*set[[:space:]]*( *MSDFGEN_USE_SKIA[[:space:]]*ON[[:space:]]*)/set(MSDFGEN_USE_SKIA OFF)/I' \
    -e '/^[[:space:]]*target_compile_definitions[[:space:]]*\([^)]*MSDFGEN_USE_SKIA[^)]*\)[[:space:]]*\)/Id' \
    msdfgen/CMakeLists.txt || die "patch Skia off"
}

src_configure() {
  local mycmakeargs=(
    -DBUILD_SHARED_LIBS=ON
    -DMSDF_ATLAS_GEN_BUILD_STANDALONE=OFF
    -DMSDF_ATLAS_GEN_USE_VCPKG=OFF
    -DMSDFGEN_BUILD_STANDALONE=OFF
    -DMSDFGEN_USE_VCPKG=OFF
    -DMSDFGEN_USE_SKIA=OFF
    -DCMAKE_DISABLE_FIND_PACKAGE_unofficial-skia=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Skia=ON
  )
  cmake_src_configure
}


