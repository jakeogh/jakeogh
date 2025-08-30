


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

  # 1) Make Skia optional (QUIET) instead of REQUIRED
  sed -i \
    -e 's|find_package(unofficial-skia REQUIRED)|find_package(unofficial-skia QUIET)|g' \
    -e 's|find_package(Skia REQUIRED)|find_package(Skia QUIET)|g' \
    msdfgen/CMakeLists.txt || die "sed: Skia REQUIRED→QUIET failed"

  # 2) Force the MSDFGEN_USE_SKIA option default OFF and neutralize any hard ON
  #    (covers patterns like: option(... ON) and set(MSDFGEN_USE_SKIA ON))
  sed -i \
    -e 's/^[[:space:]]*option[[:space:]]*(MSDFGEN_USE_SKIA[[:space:]][^)]*ON[[:space:]]*)/option(MSDFGEN_USE_SKIA "Use Skia" OFF)/I' \
    -e 's/^[[:space:]]*set[[:space:]]*(MSDFGEN_USE_SKIA[[:space:]]*ON[[:space:]]*)/set(MSDFGEN_USE_SKIA OFF)/I' \
    msdfgen/CMakeLists.txt || die "sed: force MSDFGEN_USE_SKIA=OFF failed"

  # 3) Remove any Skia link tokens so a stray target_link_libraries won’t reintroduce it
  sed -i \
    -e 's/[[:space:]]\+unofficial::skia::skia\>//g' \
    -e 's/[[:space:]]\+Skia::skia\>//g' \
    msdfgen/CMakeLists.txt || die "sed: strip Skia link targets failed"
}



src_configure() {
  local mycmakeargs=(
    -DBUILD_SHARED_LIBS=ON
    -DMSDF_ATLAS_GEN_BUILD_STANDALONE=OFF
    -DMSDF_ATLAS_GEN_USE_VCPKG=OFF
    -DMSDF_ATLAS_GEN_USE_SKIA=OFF

    # Embedded msdfgen knobs
    -DMSDFGEN_USE_SKIA=OFF
    -DMSDFGEN_USE_VCPKG=OFF
    -DMSDFGEN_BUILD_STANDALONE=OFF

    # Belt-and-suspenders: prevent accidental Skia discovery
    -DCMAKE_DISABLE_FIND_PACKAGE_unofficial-skia=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Skia=ON
  )
  cmake_src_configure
}


