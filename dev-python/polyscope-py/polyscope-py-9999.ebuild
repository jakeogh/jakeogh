# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3

DESCRIPTION="Python bindings for Polyscope, a C++/Python library for visualizing 3D data"
HOMEPAGE="https://polyscope.run"
EGIT_REPO_URI="https://github.com/nmwsharp/polyscope-py.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Runtime dependencies
RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyglm[${PYTHON_USEDEP}]
	dev-python/pyqt6[${PYTHON_USEDEP}]
"

# Build-time
DEPEND="
	${RDEPEND}
	dev-python/pybind11
	dev-build/cmake
	net-libs/nodejs
"

src_prepare() {
	# Run default prepare
	distutils-r1_src_prepare
}

python_configure() {
	local BUILDDIR="${BUILD_DIR}"
	mkdir -p "${BUILDDIR}"
	cd "${BUILDDIR}" || die

	# Run cmake directly with PYTHON_EXECUTABLE set
	cmake "${S}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX="/usr" \
		-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
		-DPYTHON_EXECUTABLE="${PYTHON}" \
		-DUSE_PYTHON=ON \
		|| die "cmake failed"
}

python_compile() {
	local BUILDDIR="${BUILD_DIR}"
	cd "${BUILDDIR}" || die
	cmake --build . --config Release || die "build failed"
}

python_install() {
	local BUILDDIR="${BUILD_DIR}"
	cd "${BUILDDIR}" || die

	# Find the compiled extension: polyscope*.so
	local ext=$(find . -name "polyscope*.so" | head -n1)
	if [[ -f "${ext}" ]]; then
		insinto "${PYTHON_SITEDIR}"
		doins "${ext}" || die "Failed to install ${ext}"
	else
		die "polyscope Python extension not found"
	fi

	# Ensure the module is importable
	touch "${D}/${PYTHON_SITEDIR}/polyscope.py" 2>/dev/null || true
}

pkg_postinst() {
	elog "polyscope-py successfully installed!"
	elog "Try it: python -c 'import polyscope as ps; ps.init(backend=\"PyQt6\"); ps.register_point_cloud(\"points\", [[0,0,0], [1,1,1]]); ps.show()'"
	elog "Documentation: https://polyscope.run"
}

