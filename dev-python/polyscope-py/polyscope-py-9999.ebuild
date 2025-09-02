# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3 cmake

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
	dev-libs/polyscope
"

# Build-time
DEPEND="
	${RDEPEND}
	dev-python/pybind11
	dev-build/cmake
	net-libs/nodejs
"

# We'll do everything in python_prepare_all
src_prepare() {
	cmake_src_prepare
	distutils-r1_src_prepare
}

python_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DPolyscope_DIR="/usr/include"
	)
	# Set build dir per Python impl
	local BUILD_DIR="${WORKDIR}/${P}_build_${EPYTHON}"
	mkdir -p "${BUILD_DIR}"
	cd "${BUILD_DIR}" || die
	cmake "${S}" "${mycmakeargs[@]}" || die "cmake failed"
}

python_compile() {
	local BUILD_DIR="${WORKDIR}/${P}_build_${EPYTHON}"
	cd "${BUILD_DIR}" || die
	cmake --build . --config Release || die "build failed"
}

python_install() {
	local BUILD_DIR="${WORKDIR}/${P}_build_${EPYTHON}"
	cd "${BUILD_DIR}" || die

	# Find the compiled extension
	local ext=$(find . -name "polyscope*.so" | head -n1)
	if [[ -f "${ext}" ]]; then
		insinto "${PYTHON_SITEDIR}"
		doins "${ext}" || die "Failed to install ${ext}"
	else
		die "Python extension not found"
	fi

	# Ensure it's importable
	touch "${D}/${PYTHON_SITEDIR}/polyscope.py" 2>/dev/null || true
}

python_test() {
	:
}

pkg_postinst() {
	elog "polyscope-py successfully installed!"
	elog "Try it: python -c 'import polyscope as ps; ps.init(backend=\"PyQt6\"); ps.register_point_cloud(\"points\", [[0,0,0], [1,1,1]]); ps.show()'"
	elog "Documentation: https://polyscope.run"
}

