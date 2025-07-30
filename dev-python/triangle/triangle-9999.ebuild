# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Python bindings to the triangle library"
HOMEPAGE="
	https://rufat.be/triangle/
	https://github.com/drufat/triangle/
	https://pypi.org/project/triangle/
"
EGIT_REPO_URI="https://github.com/drufat/triangle.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="doc examples test"

# Core dependencies based on setup.py and pyproject.toml
RDEPEND="
	>=dev-python/numpy-1.10[${PYTHON_USEDEP}]
"

# Build dependencies - Cython is required for live ebuild
BDEPEND="
	>=dev-python/cython-0.28[${PYTHON_USEDEP}]
	>=dev-python/setuptools-61[${PYTHON_USEDEP}]
	dev-vcs/git
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DOCS=( README.rst )

# Submodule handling for Jonathan Shewchuk's Triangle C library
src_unpack() {
	git-r3_src_unpack
	cd "${S}" || die

	# Initialize submodules to get the Triangle C library
	git submodule update --init --recursive || die "Failed to initialize submodules"
}

python_prepare_all() {
	# Remove any pre-generated Cython C files to ensure fresh compilation
	rm -f triangle/core.c || die

	# Ensure we have the Triangle C library source
	if [[ ! -f c/triangle.c ]]; then
		die "Triangle C library source not found. Submodule initialization may have failed."
	fi

	# Patch setup.py to build from .pyx instead of .c for live ebuild
	sed -i "s/'triangle\/core\.c'/'triangle\/core.pyx'/" setup.py || die "Failed to patch setup.py"

	# Add cython import to setup.py if not present
	if ! grep -q "from Cython.Build import cythonize" setup.py; then
		sed -i '1i from Cython.Build import cythonize' setup.py || die "Failed to add cython import"
		sed -i 's/ext_modules=ext_modules,/ext_modules=cythonize(ext_modules),/' setup.py || die "Failed to add cythonize call"
	fi

	distutils-r1_python_prepare_all
}

python_compile() {
	# Set up proper compilation environment
	export CFLAGS="${CFLAGS} -DVOID=void -DREAL=double -DNO_TIMER=1 -DTRILIBRARY=1 -DANSI_DECLARATORS=1"

	# Ensure numpy is available for Cython compilation
	export CPPFLAGS="${CPPFLAGS} -I$(${EPYTHON} -c 'import numpy; print(numpy.get_include())')"

	# Ensure Cython generates fresh C code from .pyx files
	distutils-r1_python_compile
}

python_test() {
	# Basic import test
	cd "${BUILD_DIR}/install$(python_get_sitedir)" || die
	"${EPYTHON}" -c "import triangle; print('Triangle version:', triangle.__version__)" || die "Import test failed"

	# Run actual tests if they exist
	if use test; then
		cd "${S}" || die
		epytest -v || die "Tests failed"
	fi
}

python_install_all() {
	distutils-r1_python_install_all

	if use doc; then
		local DOCS=( README.rst )
		einstalldocs

		# Install examples if requested
		if use examples; then
			docinto examples
			dodoc -r examples/* || true  # examples dir may not exist
		fi
	fi
}


pkg_postinst() {
	elog "Triangle is a Python wrapper around Jonathan Richard Shewchuk's"
	elog "two-dimensional quality mesh generator and Delaunay triangulator."
	elog ""
	elog "Key features:"
	elog "  - Exact Delaunay triangulations"
	elog "  - Constrained Delaunay triangulations"
	elog "  - Conforming Delaunay triangulations"
	elog "  - Voronoi diagrams"
	elog "  - High-quality triangular meshes suitable for finite element analysis"
	elog ""
	elog "This library is used by VisPy for fast polygon triangulation with"
	elog "significant performance improvements over pure Python implementations."
	elog ""
	elog "Usage example:"
	elog "  import numpy as np"
	elog "  import triangle as tr"
	elog "  pts = np.array([[0, 0], [1, 0], [1, 1], [0, 1]])"
	elog "  tri = tr.triangulate({'vertices': pts}, 'p')"
	elog ""
	elog "Documentation: https://rufat.be/triangle/"
	elog "Original Triangle library: https://www.cs.cmu.edu/~quake/triangle.html"
}

# Note: Restricting tests for live ebuild as they may be unstable during development
RESTRICT="!test? ( test )"
