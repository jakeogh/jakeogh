# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3 cmake

DESCRIPTION="A lightweight, cross-platform C++/Python library for visualizing 3D data"
HOMEPAGE="https://polyscope.run"
EGIT_REPO_URI="https://github.com/nmwsharp/polyscope.git"
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
	# Ensure pyproject.toml exists
	cat > pyproject.toml << 'EOF'
[build-system]
requires = ["setuptools >= 61.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "polyscope"
version = "9999"
description = "A lightweight, cross-platform C++/Python library for visualizing 3D data"
requires-python = ">=3.8"
license = {text = "MIT"}
dependencies = [
    "numpy",
    "pyglm",
    "PyQt6"
]
EOF

	# Run cmake prepare step
	cmake_src_prepare

	# Run distutils prepare (for Python)
	distutils-r1_src_prepare
}

src_configure() {
	# Configure CMake
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DUSE_PYTHON=ON
		-DIMGUI_DIR="${S}/deps/imgui"
		-DIMGLIB_DIR="${S}/deps/imghdr"
		-DHAPPY_DIR="${S}/deps/happly"
		-DGLM_DIR="${S}/deps/glm"
		-DIMPlot_DIR="${S}/deps/imgui/implot"
	)
	cmake_src_configure
}

python_compile() {
	cd "${S}/python" || die
	python_setup build_ext --inplace || die "Failed to build polyscope Python bindings"
}

python_install() {
	cd "${S}/python" || die
	python_setup install --prefix="${D%/usr}" || die "Install failed"
}

python_test() {
	:
}

pkg_postinst() {
	elog "polyscope successfully installed!"
	elog "Try it: python -c 'import polyscope as ps; ps.init(backend=\"PyQt6\"); ps.register_point_cloud(\"points\", [[0,0,0], [1,1,1]]); ps.show()'"
	elog "Documentation: https://polyscope.run"
}

