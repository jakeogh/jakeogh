


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

  # Make Skia find optional instead of REQUIRED
  sed -i \
    -e 's|find_package(unofficial-skia REQUIRED)|find_package(unofficial-skia QUIET)|g' \
    -e 's|find_package(Skia REQUIRED)|find_package(Skia QUIET)|g' \
    msdfgen/CMakeLists.txt \
    || die "sed Skia REQUIRED→QUIET failed"

  # Remove any hard Skia link tokens so target_link_libraries() won't require it
  sed -i \
    -e 's/[[:space:]]\+unofficial::skia::skia\>//g' \
    -e 's/[[:space:]]\+Skia::skia\>//g' \
    msdfgen/CMakeLists.txt \
    || die "sed remove Skia link token failed"
}

src_configure() {
  # Create a tiny top-include to define a no-op Skia target if anything still references it
  local top_inc="${T}/noskia.cmake"
  cat > "${top_inc}" <<'CMAKE' || die
# Executed via CMAKE_PROJECT_TOP_LEVEL_INCLUDES before project() finishes.
if(NOT TARGET unofficial::skia::skia)
  add_library(unofficial::skia::skia INTERFACE IMPORTED)
endif()
if(NOT TARGET Skia::skia)
  add_library(Skia::skia INTERFACE IMPORTED)
endif()
CMAKE

  local mycmakeargs=(
    -DBUILD_SHARED_LIBS=ON
    -DMSDF_ATLAS_GEN_BUILD_STANDALONE=OFF
    -DMSDF_ATLAS_GEN_USE_VCPKG=OFF
    -DMSDF_ATLAS_GEN_USE_SKIA=OFF
    -DMSDFGEN_USE_SKIA=OFF
    -DMSDFGEN_USE_VCPKG=OFF
    -DMSDFGEN_BUILD_STANDALONE=OFF
    # Nice-to-have guards (now harmless after sed)
    -DCMAKE_DISABLE_FIND_PACKAGE_unofficial-skia=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Skia=ON
    # Inject our stub before project() so any late references don’t explode
    -DCMAKE_PROJECT_TOP_LEVEL_INCLUDES="${top_inc}"
  )
  cmake_src_configure
}
