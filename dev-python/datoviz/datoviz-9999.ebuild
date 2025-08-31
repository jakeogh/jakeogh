# Copyright 2025
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_12 python3_13 )

inherit cmake git-r3 multilib python-r1

DESCRIPTION="Datoviz core + Python wrapper (ctypes) – live ebuild wired to system deps"
HOMEPAGE="https://github.com/datoviz/datoviz"

EGIT_REPO_URI="https://github.com/datoviz/datoviz.git"
# Only fetch submodules that are actually used at build/runtime.
EGIT_SUBMODULES=( data external/imgui )

LICENSE="MIT"
SLOT="0"
IUSE="test"

# don't run tests unless USE=test is on
RESTRICT="!test? ( test )"

RDEPEND="
	media-libs/glfw:=
	dev-libs/cglm:=
	dev-libs/tinyxml2:=
	media-libs/msdf-atlas-gen:=
	media-libs/libpng:=
	media-libs/freetype:=
	sys-libs/zlib:=
	media-libs/vulkan-loader:=
	>=dev-util/vulkan-headers-1.2:0
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-vcs/git
	dev-vcs/git-lfs
	>=dev-build/cmake-3.24
	>=dev-build/ninja-1.10
"

S="${WORKDIR}/${PN}-${PV}"
BUILD_DIR="${WORKDIR}/build-dvz"

src_prepare() {
	cmake_src_prepare
}

_src_write_top_include() {
	local top_include="${T}/gentoo_fetchcontent_overrides.cmake"
	cat > "${top_include}" <<'EOF'
# Provide system deps as imported targets and block FetchContent under sandbox.
if(POLICY CMP0111)
  cmake_policy(SET CMP0111 NEW)
endif()

function(_gentoo_import_lib _tgt _lib _inc)
  if(NOT TARGET "${_tgt}")
    if(EXISTS "${_lib}")
      add_library(${_tgt} SHARED IMPORTED GLOBAL)
      set_target_properties(${_tgt} PROPERTIES
        IMPORTED_LOCATION "${_lib}"
        INTERFACE_INCLUDE_DIRECTORIES "${_inc}")
    else()
      message(STATUS "Gentoo: library for target ${_tgt} not found at: ${_lib}")
    endif()
  endif()
endfunction()

# tinyxml2
if(NOT TARGET tinyxml2)
  find_package(TinyXML2 QUIET)
  if(TARGET TinyXML2::TinyXML2 AND NOT TARGET tinyxml2)
    get_target_property(_loc TinyXML2::TinyXML2 IMPORTED_LOCATION)
    if(NOT _loc)
      get_target_property(_loc TinyXML2::TinyXML2 IMPORTED_LOCATION_RELEASE)
    endif()
    get_target_property(_inc TinyXML2::TinyXML2 INTERFACE_INCLUDE_DIRECTORIES)
    if(NOT _inc)
      set(_inc "/usr/include")
    endif()
    if(_loc)
      _gentoo_import_lib(tinyxml2 "${_loc}" "${_inc}")
    endif()
  endif()
endif()
if(NOT TARGET tinyxml2)
  find_library(TINYXML2_LIB tinyxml2)
  find_path(TINYXML2_INC tinyxml2.h PATH_SUFFIXES tinyxml2)
  if(NOT TINYXML2_INC)
    set(TINYXML2_INC "/usr/include")
  endif()
  if(TINYXML2_LIB)
    _gentoo_import_lib(tinyxml2 "${TINYXML2_LIB}" "${TINYXML2_INC}")
  else()
    message(FATAL_ERROR "System tinyxml2 not found. Please install dev-libs/tinyxml2.")
  endif()
endif()

# cglm
if(NOT TARGET cglm AND NOT TARGET cglm::cglm)
  find_package(cglm QUIET)
endif()
if(NOT TARGET cglm AND NOT TARGET cglm::cglm)
  find_library(CGLM_LIB cglm)
  set(CGLM_INC "/usr/include")
  if(CGLM_LIB)
    _gentoo_import_lib(cglm "${CGLM_LIB}" "${CGLM_INC}")
    if(NOT TARGET cglm::cglm)
      add_library(cglm::cglm SHARED IMPORTED GLOBAL)
      set_target_properties(cglm::cglm PROPERTIES
        IMPORTED_LOCATION "${CGLM_LIB}"
        INTERFACE_INCLUDE_DIRECTORIES "${CGLM_INC}")
    endif()
  else()
    message(FATAL_ERROR "System cglm not found. Please install dev-libs/cglm.")
  endif()
endif()

# glfw
if(NOT TARGET glfw AND NOT TARGET glfw::glfw)
  find_package(PkgConfig QUIET)
  if(PKG_CONFIG_FOUND)
    pkg_check_modules(GLFW3 QUIET glfw3)
  endif()
  find_path(GLFW_INC GLFW/glfw3.h PATHS ${GLFW3_INCLUDE_DIRS} /usr/include /usr/include/GLFW)
  find_library(GLFW_LIB NAMES glfw glfw3 PATHS ${GLFW3_LIBRARY_DIRS})
  if(GLFW_LIB)
    if(NOT GLFW_INC)
      set(GLFW_INC "/usr/include")
    endif()
    if(NOT TARGET glfw)
      add_library(glfw SHARED IMPORTED GLOBAL)
      set_target_properties(glfw PROPERTIES IMPORTED_LOCATION "${GLFW_LIB}" INTERFACE_INCLUDE_DIRECTORIES "${GLFW_INC}")
    endif()
    if(NOT TARGET glfw::glfw)
      add_library(glfw::glfw SHARED IMPORTED GLOBAL)
      set_target_properties(glfw::glfw PROPERTIES IMPORTED_LOCATION "${GLFW_LIB}" INTERFACE_INCLUDE_DIRECTORIES "${GLFW_INC}")
    endif()
  else()
    message(FATAL_ERROR "System GLFW not found. Please install media-libs/glfw.")
  endif()
endif()

# msdf-atlas-gen
if(NOT TARGET msdf-atlas-gen::msdf-atlas-gen)
  find_library(MSDF_ATLAS_GEN_LIB NAMES msdf-atlas-gen)
  set(MSDF_ATLAS_GEN_INC "/usr/include")
  if(MSDF_ATLAS_GEN_LIB)
    add_library(msdf-atlas-gen::msdf-atlas-gen SHARED IMPORTED GLOBAL)
    set_target_properties(msdf-atlas-gen::msdf-atlas-gen PROPERTIES
      IMPORTED_LOCATION "${MSDF_ATLAS_GEN_LIB}"
      INTERFACE_INCLUDE_DIRECTORIES "${MSDF_ATLAS_GEN_INC}")
  else()
    message(FATAL_ERROR "Could not resolve library file for msdf-atlas-gen. Install media-libs/msdf-atlas-gen.")
  endif()
endif()

set(FETCHCONTENT_FULLY_DISCONNECTED ON CACHE BOOL "" FORCE)
EOF
	echo "${top_include}"

  # CMake TOP_LEVEL_INCLUDES runs before project(); avoid find_package(tinyxml2) there.
  # Replace it with a pre-project-safe imported target definition.
  sed -i -e '/^[[:space:]]*find_package[[:space:]]*(\s*tinyxml2[^)]*)/Id' \
    "${T}/gentoo_fetchcontent_overrides.cmake" || die

  cat >> "${T}/gentoo_fetchcontent_overrides.cmake" <<'EOF'
# ---- tinyxml2 (pre-project safe) --------------------------------------------
if(NOT TARGET tinyxml2::tinyxml2)
  find_library(TINYXML2_LIB NAMES tinyxml2 REQUIRED)
  find_path(TINYXML2_INC_DIR NAMES tinyxml2.h PATHS /usr/include /usr/include/tinyxml2 REQUIRED)
  add_library(tinyxml2::tinyxml2 UNKNOWN IMPORTED)
  set_target_properties(tinyxml2::tinyxml2 PROPERTIES
    IMPORTED_LOCATION "${TINYXML2_LIB}"
    INTERFACE_INCLUDE_DIRECTORIES "${TINYXML2_INC_DIR}")
endif()
# -----------------------------------------------------------------------------

EOF




}

src_configure() {
	local top_include
	top_include=$(_src_write_top_include) || die

	local -a mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DCMAKE_PROJECT_TOP_LEVEL_INCLUDES="${top_include}"
		-DCMAKE_PREFIX_PATH="/usr/$(get_libdir)/cmake;/usr/$(get_libdir)"
		-DBUILD_TESTING=$(usex test ON OFF)
	)

	cmake_src_configure \
		-S "${S}" \
		-B "${BUILD_DIR}" \
		-G Ninja \
        -DTINYXML2_INC_DIR=/usr/include \
        -DTINYXML2_INCLUDE_DIR=/usr/include \
        -DTINYXML2_LIBRARY="/usr/$(get_libdir)/libtinyxml2.so" \
        -DTINYXML2_LIBRARIES="/usr/$(get_libdir)/libtinyxml2.so" \
		"${mycmakeargs[@]}"
}

src_compile() {
	cmake_build -C "${BUILD_DIR}"
}

src_test() {
	# only run if enabled (RESTRICT covers the default-off case)
	if use test; then
		cmake_src_test -C "${BUILD_DIR}"
	fi
}

src_install() {
	cmake_install -C "${BUILD_DIR}"

	# Install Python ctypes wrapper and provide lib symlink it expects.
	local psrc="${S}/python/datoviz"
	if [[ ! -d ${psrc} ]]; then
		ewarn "python/datoviz not found; attempting fallback to ${S}/bindings/python/datoviz"
		psrc="${S}/bindings/python/datoviz"
	fi
	if [[ ! -d ${psrc} ]]; then
		die "Could not find Datoviz Python sources; please adjust ebuild."
	fi

	python_foreach_impl python_install
}

python_install() {
	local pydir
	pydir="$(python_get_sitedir)" || die
	insinto "${pydir}/datoviz"
	doins -r "${S}/python/datoviz/"* || die

	# ensure _ctypes loader finds libdatoviz.so at datoviz/build/libdatoviz.so
	dodir "${pydir}/datoviz/build"
	dosym -r "/usr/$(get_libdir)/libdatoviz.so" \
		"${pydir}/datoviz/build/libdatoviz.so" || die
}

pkg_postinst() {
	elog "Datoviz built against system libraries (glfw, cglm, tinyxml2, msdf-atlas-gen, freetype, png, zlib)."
	elog "If Python import fails with ctypes lookup errors, confirm the symlink:"
	elog "  <site-packages>/datoviz/build/libdatoviz.so -> /usr/$(get_libdir)/libdatoviz.so"
}

