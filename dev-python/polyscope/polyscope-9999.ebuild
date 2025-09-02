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

#dev-libs/polyscope
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
	# Run cmake prepare step
	cmake_src_prepare
	distutils-r1_src_prepare
}

src_configure() {
	# Explicitly set PYTHON_EXECUTABLE
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DPYTHON_EXECUTABLE="${PYTHON:-python}"
		-DPolyscope_DIR="/usr/include"
	)
	einfo "Using PYTHON_EXECUTABLE=${mycmakeargs[1]#*=}"
	cmake_src_configure
}

python_compile() {
	cd "${BUILD_DIR}" || die
	distutils-r1_python_compile
}

python_install() {
	cd "${BUILD_DIR}" || die
	distutils-r1_python_install
}

pkg_postinst() {
	elog "polyscope Python bindings successfully installed!"
	elog "Try it: python -c 'import polyscope as ps; ps.init(backend=\"PyQt6\"); ps.register_point_cloud(\"points\", [[0,0,0], [1,1,1]]); ps.show()'"
	elog "Documentation: https://polyscope.run"
}

