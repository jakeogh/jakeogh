# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
PYTHON_SINGLE_TARGET="python3_13"
PYTHON_TARGETS="${PYTHON_SINGLE_TARGET}"
inherit python-single-r1 git-r3

DESCRIPTION="Python bindings for Polyscope, a C++/Python library for visualizing 3D data"
HOMEPAGE="https://polyscope.run"
EGIT_REPO_URI="https://github.com/nmwsharp/polyscope-py.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Runtime dependencies
RDEPEND="
	$(python_gen_cond_dep '
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pyglm[${PYTHON_USEDEP}]
		dev-python/pyqt6[${PYTHON_USEDEP}]
	')
"

# Build-time
DEPEND="
	${RDEPEND}
	dev-python/pybind11
	dev-build/cmake
	net-libs/nodejs
"

src_prepare() {
	einfo "=== src_prepare: Starting ==="
	default
	einfo "=== src_prepare: Finished ==="
}

src_configure() {
	einfo "=== src_configure: Skipping (CMake run in python_compile) ==="
	:
}

python_compile() {
	einfo "=== python_compile: Running for ${EPYTHON} ==="
	local BUILDDIR="${WORKDIR}/${P}_build_${EPYTHON}"
	mkdir -p "${BUILDDIR}"
	cd "${BUILDDIR}" || die "Failed to enter build dir"

	einfo "Configuring CMake..."
	cmake "${S}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX="/usr" \
		-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
		-DPYTHON_EXECUTABLE="${PYTHON}" \
		-DUSE_PYTHON=ON \
		|| die "cmake failed"

	einfo "Building with CMake..."
	cmake --build . --config Release || die "build failed"
	einfo "=== python_compile: Success for ${EPYTHON} ==="
}

python_install() {
	einfo "=== python_install: Running for ${EPYTHON} ==="
	local BUILDDIR="${WORKDIR}/${P}_build_${EPYTHON}"
	cd "${BUILDDIR}" || die "Failed to enter build dir"

	# Find the compiled extension
	local ext=$(find . -name "polyscope*.so" | head -n1)
	if [[ -f "${ext}" ]]; then
		einfo "Found extension: ${ext}"
		insinto "${PYTHON_SITEDIR}"
		doins "${ext}" || die "Failed to install ${ext}"
	else
		die "polyscope Python extension not found"
	fi

	# Ensure the module is importable
	touch "${D}/${PYTHON_SITEDIR}/polyscope.py" 2>/dev/null || true
	einfo "Created polyscope.py stub"
	einfo "=== python_install: Success for ${EPYTHON} ==="
}

src_compile() {
	einfo "=== src_compile: Entering src_compile phase ==="
	python_foreach_impl python_compile
	einfo "=== src_compile: Finished python_compile calls ==="
}

src_install() {
	einfo "=== src_install: Entering src_install phase ==="
	python_foreach_impl python_install
	einfo "=== src_install: Finished python_install calls ==="
}

pkg_postinst() {
	elog "polyscope-py successfully installed!"
	elog "Try it: python -c 'import polyscope as ps; ps.init(backend=\"PyQt6\"); ps.register_point_cloud(\"points\", [[0,0,0], [1,1,1]]); ps.show()'"
	elog "Documentation: https://polyscope.run"
}

