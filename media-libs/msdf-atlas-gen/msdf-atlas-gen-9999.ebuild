EAPI=8
inherit cmake git-r3

DESCRIPTION="Multi-channel signed distance field atlas generator (live git)"
HOMEPAGE="https://github.com/Chlumsky/msdf-atlas-gen"
EGIT_REPO_URI="https://github.com/Chlumsky/msdf-atlas-gen.git"
EGIT_BRANCH="master"
EGIT_SUBMODULES=( '*' )

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="+cli"

RDEPEND="
  media-libs/libpng:0=
  sys-libs/zlib
  dev-libs/tinyxml2
  media-libs/freetype:2
"
DEPEND="${RDEPEND}"
BDEPEND="dev-build/cmake"

src_prepare() {
    cmake_src_prepare

    if [[ ! -d "${S}/msdfgen" ]]; then
        die "msdfgen submodule not fetched"
    fi

    pushd msdfgen >/dev/null || die
    sed -i -r \
        -e 's/find_package\(\s*unofficial-skia[^)]*\)/find_package(unofficial-skia QUIET)/Ig' \
        -e 's/find_package\(\s*Skia[^)]*\)/find_package(Skia QUIET)/Ig' \
        -e 's/^[[:space:]]*option\(\s*MSDFGEN_USE_SKIA[^)]*\)/option(MSDFGEN_USE_SKIA "Use Skia" OFF)/I' \
        -e 's/^[[:space:]]*set\(\s*MSDFGEN_USE_SKIA\s+ON\s*\)/set(MSDFGEN_USE_SKIA OFF)/I' \
        -e 's/^[[:space:]]*if\(\s*MSDFGEN_USE_SKIA\s*\)/if(FALSE)/I' \
        -e 's/^[[:space:]]*elseif\(\s*MSDFGEN_USE_SKIA\s*\)/elseif(FALSE)/I' \
        CMakeLists.txt || die
    popd >/dev/null || die
}

src_configure() {
    local -a mycmakeargs=(
        -DBUILD_SHARED_LIBS=ON
        -DMSDF_ATLAS_BUILD_STANDALONE=$(usex cli ON OFF)
        -DMSDF_ATLAS_USE_VCPKG=OFF
        -DMSDF_ATLAS_USE_SKIA=OFF
        -DMSDF_ATLAS_MSDFGEN_EXTERNAL=OFF
        -DMSDF_ATLAS_INSTALL=ON
        -DMSDFGEN_BUILD_STANDALONE=OFF
        -DMSDFGEN_USE_VCPKG=OFF
        -DMSDFGEN_USE_SKIA=OFF
        -DCMAKE_DISABLE_FIND_PACKAGE_unofficial-skia=ON
        -DCMAKE_DISABLE_FIND_PACKAGE_Skia=ON
        -DCMAKE_DISABLE_FIND_PACKAGE_msdfgen=ON
        -DCMAKE_SKIP_RPATH=ON
    )
    cmake_src_configure "${mycmakeargs[@]}"
}

src_install() {
  local libdir=$(get_libdir)

  # Only install msdf-atlas-gen library (statically link bundled msdfgen)
  dolib.so "${BUILD_DIR}/libmsdf-atlas-gen.so" || die

  # Also install bundled msdfgen libs with different names to avoid collision
  newlib.so "${BUILD_DIR}/msdfgen/libmsdfgen-core.so" libmsdfgen-core-bundled.so
  newlib.so "${BUILD_DIR}/msdfgen/libmsdfgen-ext.so" libmsdfgen-ext-bundled.so

  # Only install msdf-atlas-gen headers
  insinto /usr/include/msdf-atlas-gen
  doins "${S}"/msdf-atlas-gen/*.h || die
  [[ -f "${S}/msdf-atlas-gen/rectangle-packing.hpp" ]] || die "Missing rectangle-packing.hpp"
  doins "${S}"/msdf-atlas-gen/*.hpp || die

  if use cli && [[ -x ${BUILD_DIR}/bin/msdf-atlas-gen ]]; then
    dobin "${BUILD_DIR}/bin/msdf-atlas-gen" || die
  fi

  local cmakedir="/usr/${libdir}/cmake/msdf-atlas-gen"
  insinto "${cmakedir}"
  cat > "${T}/msdf-atlas-genConfig.cmake" <<'EOF' || die
if(NOT TARGET msdf-atlas-gen::msdf-atlas-gen)
  add_library(msdfgen-core-bundled SHARED IMPORTED)
  set_target_properties(msdfgen-core-bundled PROPERTIES
    IMPORTED_LOCATION "/usr/@LIBDIR@/libmsdfgen-core-bundled.so")

  add_library(msdfgen-ext-bundled SHARED IMPORTED)
  set_target_properties(msdfgen-ext-bundled PROPERTIES
    IMPORTED_LOCATION "/usr/@LIBDIR@/libmsdfgen-ext-bundled.so"
    INTERFACE_LINK_LIBRARIES "msdfgen-core-bundled")

  add_library(msdf-atlas-gen::msdf-atlas-gen SHARED IMPORTED)
  set_target_properties(msdf-atlas-gen::msdf-atlas-gen PROPERTIES
    IMPORTED_LOCATION "/usr/@LIBDIR@/libmsdf-atlas-gen.so"
    INTERFACE_INCLUDE_DIRECTORIES "/usr/include/msdf-atlas-gen"
    INTERFACE_LINK_LIBRARIES "msdfgen-ext-bundled;msdfgen-core-bundled")
endif()
EOF
  sed -i "s|@LIBDIR@|${libdir}|g" "${T}/msdf-atlas-genConfig.cmake" || die
  doins "${T}/msdf-atlas-genConfig.cmake" || die

  if type -P patchelf >/dev/null ; then
    patchelf --remove-rpath "${ED}/usr/${libdir}/libmsdf-atlas-gen.so" || die
    patchelf --remove-rpath "${ED}/usr/${libdir}/libmsdfgen-core-bundled.so" 2>/dev/null
    patchelf --remove-rpath "${ED}/usr/${libdir}/libmsdfgen-ext-bundled.so" 2>/dev/null
    if use cli && [[ -x ${ED}/usr/bin/msdf-atlas-gen ]]; then
      patchelf --remove-rpath "${ED}/usr/bin/msdf-atlas-gen" || die
    fi
  fi

  einstalldocs
}
