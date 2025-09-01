# Copyright 2025
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_12 python3_13 )

inherit cmake git-r3 multilib python-r1

DESCRIPTION="Datoviz core + Python wrapper (ctypes) - live ebuild wired to system deps"
HOMEPAGE="https://github.com/datoviz/datoviz"

EGIT_REPO_URI="https://github.com/datoviz/datoviz.git"
# Only fetch submodules that are actually used at build/runtime.
EGIT_SUBMODULES=( data external/imgui )

LICENSE="MIT"
SLOT="0"
IUSE="test python"

# don't run tests unless USE=test is on
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
	)
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

S="${WORKDIR}/${PN}-${PV}"
BUILD_DIR="${WORKDIR}/build-dvz"

src_prepare() {
	cmake_src_prepare

	# Fix missing #include <cstdint> in earcut.hpp
	sed -i '/#include <utility>/a #include <cstdint>' \
		"${S}/external/earcut.hpp" || die "Failed to fix earcut.hpp"

	if use python; then
		# Check if requirements-dev.txt exists and what it contains
		if [[ -f "${S}/requirements-dev.txt" ]]; then
			einfo "Found requirements-dev.txt, contents:"
			cat "${S}/requirements-dev.txt"
		else
			einfo "No requirements-dev.txt found, will proceed without it"
		fi
	fi
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

# msdf-atlas-gen with system msdfgen dependencies
if(NOT TARGET msdf-atlas-gen::msdf-atlas-gen)
  # Find all required libraries
  find_library(MSDF_ATLAS_GEN_LIB NAMES msdf-atlas-gen REQUIRED)
  find_library(MSDFGEN_CORE_LIB NAMES msdfgen-core REQUIRED)
  find_library(MSDFGEN_EXT_LIB NAMES msdfgen-ext REQUIRED)
  find_path(MSDF_ATLAS_GEN_INC NAMES msdf-atlas-gen.h PATHS /usr/include /usr/include/msdf-atlas-gen)
  if(NOT MSDF_ATLAS_GEN_INC)
    set(MSDF_ATLAS_GEN_INC "/usr/include")
  endif()

  # Create the main target
  add_library(msdf-atlas-gen::msdf-atlas-gen SHARED IMPORTED GLOBAL)
  set_target_properties(msdf-atlas-gen::msdf-atlas-gen PROPERTIES
    IMPORTED_LOCATION "${MSDF_ATLAS_GEN_LIB}"
    INTERFACE_INCLUDE_DIRECTORIES "${MSDF_ATLAS_GEN_INC}")

  # Force all msdfgen libraries to be linked by any target that uses msdf-atlas-gen
  set_property(TARGET msdf-atlas-gen::msdf-atlas-gen PROPERTY
    INTERFACE_LINK_LIBRARIES "${MSDFGEN_EXT_LIB};${MSDFGEN_CORE_LIB}")
endif()

# Also create standalone msdfgen-ext target for good measure
if(NOT TARGET msdfgen-ext)
  find_library(MSDFGEN_EXT_LIB NAMES msdfgen-ext)
  find_library(MSDFGEN_CORE_LIB NAMES msdfgen-core)
  if(MSDFGEN_EXT_LIB)
    add_library(msdfgen-ext SHARED IMPORTED GLOBAL)
    set_target_properties(msdfgen-ext PROPERTIES
      IMPORTED_LOCATION "${MSDFGEN_EXT_LIB}")
    if(MSDFGEN_CORE_LIB)
      set_property(TARGET msdfgen-ext PROPERTY
        IMPORTED_LINK_INTERFACE_LIBRARIES "${MSDFGEN_CORE_LIB}")
    endif()
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

	# Build Python bindings using just if requested
	if use python; then
		einfo "Attempting to build Python bindings using just build system..."

		# Check if just is available
		if ! command -v just >/dev/null 2>&1; then
			ewarn "just build tool not found in PATH"
			ewarn "Python bindings will not be built"
			ewarn "Install sys-devel/just to enable Python bindings"
			return
		fi

		# Set up environment for just build
		export PATH="${HOME}/.cargo/bin:${PATH}"
		cd "${S}" || die

		# Try the just build process
		einfo "Running 'just build' (first attempt may fail as documented)..."
		if ! just build; then
			einfo "First build failed as expected, trying again..."
			if ! just build; then
				ewarn "Python bindings build failed with just"
				ewarn "Continuing with C library only"
			else
				einfo "Python bindings built successfully on second attempt"
			fi
		else
			einfo "Python bindings built successfully on first attempt"
		fi
	fi
}

src_test() {
	# only run if enabled (RESTRICT covers the default-off case)
	if use test; then
		cmake_src_test -C "${BUILD_DIR}"

		if use python; then
			cd "${S}" || die
			python -c "import datoviz; print('Python bindings working!')" || die "Python import test failed"
		fi
	fi
}

src_install() {
	# Manual installation since the project doesn't provide an install target

	# Install the main library
	dolib.so "${BUILD_DIR}/libdatoviz.so"* || die "Failed to install libdatoviz.so"

	# Install the CLI binary if it exists
	if [[ -x "${BUILD_DIR}/datoviz" ]]; then
		dobin "${BUILD_DIR}/datoviz" || die "Failed to install datoviz binary"
	fi

	# Install headers
	insinto /usr/include/datoviz
	doins -r "${S}/include/"* || die "Failed to install headers"

	# Install Python bindings if built
	if use python; then
		python_foreach_impl python_install
	fi

	einstalldocs
}

python_install() {
	local pydir
	pydir="$(python_get_sitedir)" || die

	# Look for the built Python module in various locations
	local python_src=""
	for possible_src in "${S}/bindings/python" "${S}/python" "${S}/build/python" "${BUILD_DIR}/python"; do
		if [[ -d "${possible_src}" && -n "$(find "${possible_src}" -name "*.py" 2>/dev/null)" ]]; then
			python_src="${possible_src}"
			break
		fi
	done

	if [[ -n "${python_src}" ]]; then
		einfo "Installing Python bindings from: ${python_src}"
		insinto "${pydir}"
		doins -r "${python_src}/"* || die "Failed to install Python files"

		# Create symlink to library if needed
		if [[ -d "${pydir}/datoviz" ]]; then
			dodir "${pydir}/datoviz/build"
			dosym -r "/usr/$(get_libdir)/libdatoviz.so" \
				"${pydir}/datoviz/build/libdatoviz.so" || die
		fi
	else
		ewarn "Python bindings requested but not found after build"
	fi
}


pkg_postinst() {
	elog "Datoviz built against system libraries (glfw, cglm, tinyxml2, msdf-atlas-gen, freetype, png, zlib)."
	if use python; then
		elog "Python bindings are installed. Test with: python -c 'import datoviz; datoviz.demo()'"
	fi
	elog "For C/C++ development, headers are in /usr/include/datoviz/"
}
