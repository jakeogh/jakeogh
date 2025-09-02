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
dependencies = ["numpy", "pyglm", "PyQt6"]
EOF

	# Run cmake prepare
	cmake_src_prepare
	distutils-r1_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DUSE_PYTHON=ON
	)
	cmake_src_configure
}

python_compile() {
	cd "${BUILD_DIR}" || die
	distutils-r1_python_compile
}

python_install() {
	cd "${BUILD_DIR}" || die

	# Find the compiled extension (e.g., polyscope.cpython-313-x86_64-linux-gnu.so)
	local ext=$(find . -name "polyscope*.so" | head -n1)
	if [[ -f "${ext}" ]]; then
		insinto "${PYTHON_SITEDIR}"
		doins "${ext}" || die "Failed to install ${ext}"
	else
		die "Python extension not found"
	fi

	# Ensure it's importable
	echo "from pathlib import Path" > "${D}/${PYTHON_SITEDIR}/polyscope.py"
	echo "__path__ = [str(Path(__file__).parent / '${ext##*/}')]" >> "${D}/${PYTHON_SITEDIR}/polyscope.py"
}

pkg_postinst() {
	elog "polyscope-py successfully installed!"
	elog "Try it: python -c 'import polyscope as ps; ps.init(backend=\"PyQt6\"); ps.register_point_cloud(\"points\", [[0,0,0], [1,1,1]]); ps.show()'"
	elog "Documentation: https://polyscope.run"
}

