


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

    # Turn off Skia in the embedded msdfgen cleanly.
    # - Demote REQUIRED -> QUIET for both finders
    # - Default option OFF (and override any forced ON)
    # - Neutralize if()/elseif(MSDFGEN_USE_SKIA) without breaking endif nesting
    pushd msdfgen >/dev/null || die
    sed -i -r \
        -e 's/find_package\(\s*unofficial-skia[^)]*\)/find_package(unofficial-skia QUIET)/Ig' \
        -e 's/find_package\(\s*Skia[^)]*\)/find_package(Skia QUIET)/Ig' \
        -e 's/^[[:space:]]*option\(\s*MSDFGEN_USE_SKIA[^)]*\)/option(MSDFGEN_USE_SKIA "Use Skia" OFF)/I' \
        -e 's/^[[:space:]]*set\(\s*MSDFGEN_USE_SKIA\s+ON\s*\)/set(MSDFGEN_USE_SKIA OFF)/I' \
        -e 's/^[[:space:]]*if\(\s*MSDFGEN_USE_SKIA\s*\)/if(FALSE)/I' \
        -e 's/^[[:space:]]*elseif\(\s*MSDFGEN_USE_SKIA\s*\)/elseif(FALSE)/I' \
        CMakeLists.txt || die "patch Skia off"
    popd >/dev/null || die
}


src_configure() {

local -a mycmakeargs=(
    -DBUILD_SHARED_LIBS=ON
    -DMSDF_ATLAS_GEN_BUILD_STANDALONE=OFF
    -DMSDF_ATLAS_GEN_USE_VCPKG=OFF
    -DMSDF_ATLAS_GEN_USE_SKIA=OFF
    -DMSDFGEN_BUILD_STANDALONE=OFF
    -DMSDFGEN_USE_VCPKG=OFF
    -DMSDFGEN_USE_SKIA=OFF
    -DCMAKE_DISABLE_FIND_PACKAGE_unofficial-skia=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Skia=ON
)
cmake_src_configure "${mycmakeargs[@]}"
}
