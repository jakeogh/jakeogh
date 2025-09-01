# Copyright 2025
# Distributed under the terms of the GNU General Public License v2
EAPI=8
PYTHON_COMPAT=( python3_12 python3_13 )
DISTUTILS_USE_PEP517=no
inherit cmake git-r3 multilib distutils-r1

DESCRIPTION="Datoviz core + Python wrapper (ctypes) - live ebuild wired to system deps"
HOMEPAGE="https://github.com/datoviz/datoviz"
EGIT_REPO_URI="https://github.com/datoviz/datoviz.git"
EGIT_SUBMODULES=( data external/imgui )
LICENSE="MIT"
SLOT="0"
IUSE="test python"
RESTRICT="!test? ( test )"

RDEPEND="
	media-libs/glfw:=
	dev-libs/cglm:=
	dev-libs/tinyxml2:=
	media-libs/msdf-atlas-gen:=
	media-libs/msdfgen:=
	media-libs/libpng:=
	media-libs/freetype:=
	sys-libs/zlib:=
	media-libs/vulkan-loader:=
	>=dev-util/vulkan-headers-1.2:0
	python? (
		${PYTHON_DEPS}
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-vcs/git
	dev-vcs/git-lfs
	>=dev-build/cmake-3.24
	>=dev-build/ninja-1.10
	python? (
		${PYTHON_DEPS}
		dev-python/pip[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
		sys-devel/just
	)
"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
S="${WORKDIR}/${PN}-${PV}"
BUILD_DIR="${WORKDIR}/build-dvz"
PYMOD_DIR="${S}/datoviz"

src_prepare() {
	cmake_src_prepare
	# Fix missing #include <cstdint> in earcut.hpp
	sed -i '/#include <utility>/a #include <cstdint>' \
		"${S}/external/earcut.hpp" || die "Failed to fix earcut.hpp"
}

_src_write_top_include() {
	local top_include="${T}/gentoo_fetchcontent_overrides.cmake"
	cat > "${top_include}" <<'EOF'
# Block FetchContent from doing anything
set(FETCHCONTENT_FULLY_DISCONNECTED ON CACHE BOOL "" FORCE)
set(FETCHCONTENT_UPDATES_DISCONNECTED ON CACHE BOOL "" FORCE)

# Override FetchContent functions to block any network access
function(FetchContent_MakeAvailable)
  message(STATUS "Blocking FetchContent_MakeAvailable")
endfunction()
function(FetchContent_Declare)
  message(STATUS "Blocking FetchContent_Declare")
endfunction()
function(FetchContent_Populate)
  message(STATUS "Blocking FetchContent_Populate")
endfunction()

# tinyxml2
if(NOT TARGET tinyxml2 AND NOT TARGET tinyxml2::tinyxml2)
  find_library(TINYXML2_LIB NAMES tinyxml2 REQUIRED)
  find_path(TINYXML2_INC_DIR NAMES tinyxml2.h PATHS /usr/include /usr/include/tinyxml2 REQUIRED)
  # Create both targets to satisfy set_target_properties(tinyxml2 ...)
  if(NOT TARGET tinyxml2)
    add_library(tinyxml2 SHARED IMPORTED)
    set_target_properties(tinyxml2 PROPERTIES
      IMPORTED_LOCATION "${TINYXML2_LIB}"
      INTERFACE_INCLUDE_DIRECTORIES "${TINYXML2_INC_DIR}")
  endif()
  if(NOT TARGET tinyxml2::tinyxml2)
    add_library(tinyxml2::tinyxml2 SHARED IMPORTED)
    set_target_properties(tinyxml2::tinyxml2 PROPERTIES
      IMPORTED_LOCATION "${TINYXML2_LIB}"
      INTERFACE_INCLUDE_DIRECTORIES "${TINYXML2_INC_DIR}")
  endif()
endif()

# cglm
if(NOT TARGET cglm AND NOT TARGET cglm::cglm)
  find_library(CGLM_LIB cglm REQUIRED)
  find_path(CGLM_INC cglm/cglm.h PATHS /usr/include NO_DEFAULT_PATH)
  if(NOT CGLM_INC)
    set(CGLM_INC "/usr/include")
  endif()
  add_library(cglm::cglm SHARED IMPORTED)
  set_target_properties(cglm::cglm PROPERTIES
    IMPORTED_LOCATION "${CGLM_LIB}"
    INTERFACE_INCLUDE_DIRECTORIES "${CGLM_INC}")
endif()

# glfw
if(NOT TARGET glfw AND NOT TARGET glfw::glfw)
  find_library(GLFW_LIB NAMES glfw glfw3 REQUIRED)
  find_path(GLFW_INC GLFW/glfw3.h PATHS /usr/include NO_DEFAULT_PATH)
  if(NOT GLFW_INC)
    set(GLFW_INC "/usr/include")
  endif()
  add_library(glfw::glfw SHARED IMPORTED)
  set_target_properties(glfw::glfw PROPERTIES
    IMPORTED_LOCATION "${GLFW_LIB}"
    INTERFACE_INCLUDE_DIRECTORIES "${GLFW_INC}")
endif()

# msdf-atlas-gen
if(NOT TARGET msdf-atlas-gen::msdf-atlas-gen)
  find_library(MSDF_ATLAS_GEN_LIB NAMES msdf-atlas-gen REQUIRED)
  find_library(MSDFGEN_CORE_LIB NAMES msdfgen-core REQUIRED)
  find_library(MSDFGEN_EXT_LIB NAMES msdfgen-ext REQUIRED)
  find_path(MSDF_ATLAS_GEN_INC NAMES msdf-atlas-gen.h PATHS /usr/include NO_DEFAULT_PATH)
  if(NOT MSDF_ATLAS_GEN_INC)
    set(MSDF_ATLAS_GEN_INC "/usr/include")
  endif()
  add_library(msdf-atlas-gen::msdf-atlas-gen SHARED IMPORTED)
  set_target_properties(msdf-atlas-gen::msdf-atlas-gen PROPERTIES
    IMPORTED_LOCATION "${MSDF_ATLAS_GEN_LIB}"
    INTERFACE_INCLUDE_DIRECTORIES "${MSDF_ATLAS_GEN_INC}")
  set_property(TARGET msdf-atlas-gen::msdf-atlas-gen PROPERTY
    INTERFACE_LINK_LIBRARIES "${MSDFGEN_EXT_LIB};${MSDFGEN_CORE_LIB}")
endif()
EOF
	echo "${top_include}"
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

	if use python; then
		einfo "Building Python bindings with 'just'..."
		cd "${S}" || die

		if ! command -v just >/dev/null 2>&1; then
			die "USE=python enabled but 'just' not found. Please install sys-devel/just."
		fi

		# First call often fails due to msdf-atlas-gen issue
		if ! just build; then
			einfo "First 'just build' failed, retrying..."
			if ! just build; then
				die "Failed to build Python bindings with 'just' after two attempts."
			fi
		fi
		einfo "Python bindings built successfully."
	fi
}

src_test() {
	if use test; then
		cmake_src_test -C "${BUILD_DIR}"
	fi
	if use python; then
		python_foreach_impl python_test
	fi
}

python_test() {
	cd "${S}" || die
	"${PYTHON}" -c "import datoviz; datoviz.demo()" || \
		die "Python module test failed for ${EPYTHON}"
}

python_install() {
	local pydir
	pydir="$(python_get_sitedir)" || die "Failed to determine Python site-packages directory"

	if [[ ! -d "${PYMOD_DIR}" ]]; then
		die "Python module not found in ${PYMOD_DIR}"
	fi

	insinto "${pydir}"
	doins -r "${PYMOD_DIR}" || die "Failed to install Python module"

	dodir "${pydir}/datoviz/build"
	dosym -r "/usr/$(get_libdir)/libdatoviz.so" \
		"${pydir}/datoviz/build/libdatoviz.so" || die "Failed to symlink libdatoviz.so"
}

src_install() {
	# Install C library and headers
	dolib.so "${BUILD_DIR}/libdatoviz.so"* || die "Failed to install libdatoviz.so"
	if [[ -x "${BUILD_DIR}/datoviz" ]]; then
		dobin "${BUILD_DIR}/datoviz"
	fi
	insinto /usr/include/datoviz
	doins -r "${S}/include/"* || die "Failed to install headers"

	einstalldocs

	# Install Python bindings
	if use python; then
		distutils-r1_src_install
	fi
}

pkg_postinst() {
	elog "Datoviz C library installed. Headers in /usr/include/datoviz/"
	elog "Shared library: /usr/$(get_libdir)/libdatoviz.so"
	if use python; then
		elog "Python bindings installed."
		elog "Test with: python -c 'import datoviz; datoviz.demo()'"
	fi
}

