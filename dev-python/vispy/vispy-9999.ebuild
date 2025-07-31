# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="High-performance interactive 2D/3D data visualization library"
HOMEPAGE="
	https://vispy.org/
	https://github.com/vispy/vispy/
	https://pypi.org/project/vispy/
"
EGIT_REPO_URI="https://github.com/vispy/vispy.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc examples jupyter test +opengl"

# Core dependencies based on setup.py and pyproject.toml
RDEPEND="
	>=dev-python/numpy-1.17.0[${PYTHON_USEDEP}]
	dev-python/hsluv[${PYTHON_USEDEP}]
	dev-python/pyqt6[${PYTHON_USEDEP},opengl,testlib]
	opengl? (
		|| (
			dev-python/pyside2[${PYTHON_USEDEP}]
			dev-python/pyside6[${PYTHON_USEDEP}]
			dev-python/wxpython[${PYTHON_USEDEP}]
			dev-python/pyglet[${PYTHON_USEDEP}]
			dev-python/glfw[${PYTHON_USEDEP}]
			dev-python/PySDL2[${PYTHON_USEDEP}]
		)
	)
"

# Build dependencies - Cython is required for live ebuild
BDEPEND="
	>=dev-python/cython-0.29.2[${PYTHON_USEDEP}]
	>=dev-python/setuptools-scm-3.4[${PYTHON_USEDEP}]
	>=dev-python/setuptools-61[${PYTHON_USEDEP}]
	dev-vcs/git
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
	)
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx-gallery[${PYTHON_USEDEP}]
		dev-python/numpydoc[${PYTHON_USEDEP}]
	)
"

# Optional runtime dependencies for enhanced functionality
PDEPEND="
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/imageio[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	jupyter? (
		dev-python/jupyter[${PYTHON_USEDEP}]
		dev-python/jupyter-rfb[${PYTHON_USEDEP}]
	)
	dev-python/triangle[${PYTHON_USEDEP}]
	dev-python/freetype-py[${PYTHON_USEDEP}]
"

# OpenGL and graphics requirements
RDEPEND+="
	virtual/opengl
	media-libs/mesa[X]
	x11-libs/libX11
	x11-libs/libXext
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# Git submodules are needed for complete build
src_unpack() {
	git-r3_src_unpack
	cd "${S}" || die
	git submodule update --init --recursive || die "Failed to initialize submodules"
}

python_prepare_all() {
	# Remove bundled dependencies if any
	rm -rf vispy/ext/six || die

	# Fix potential issues with setuptools_scm_git_archive
	# Based on AUR feedback, we remove this deprecated dependency
	if [[ -f pyproject.toml ]]; then
		sed -i '/setuptools_scm_git_archive/d' pyproject.toml || die
		# Uncomment modern setuptools requirements
		sed -i 's/# "setuptools>=42",/"setuptools>=61",/' pyproject.toml || die
		sed -i 's/# "setuptools_scm\[toml\]>=3.4",/"setuptools_scm[toml]>=3.4",/' pyproject.toml || die
	fi

	distutils-r1_python_prepare_all
}

python_compile() {
	# Set up proper numpy include paths for Cython compilation
	export CFLAGS="${CFLAGS} -I$(python -c 'import numpy; print(numpy.get_include())')"
	distutils-r1_python_compile
}

python_test() {
	epytest -x vispy/testing || die "Tests failed"
}

python_install_all() {
	distutils-r1_python_install_all

	if use doc; then
		local DOCS=( README.rst CHANGELOG.md )
		einstalldocs

		# Install examples if requested
		if use examples; then
			docinto examples
			dodoc -r examples/*
		fi
	fi

	# Install GLSL shader files
	insinto "/usr/share/${PN}"
	doins -r vispy/glsl/*
}

pkg_postinst() {
	elog "VisPy requires at least one OpenGL backend to function properly."
	elog "Supported backends include:"
	elog "  - PyQt5/PyQt6 (recommended)"
	elog "  - PySide2/PySide6"
	elog "  - wxPython"
	elog "  - pyglet"
	elog "  - GLFW"
	elog "  - PySDL2"
	elog ""
	if use jupyter; then
		elog "For Jupyter notebook support, you have jupyter-rfb installed."
		elog "Use the 'jupyter_rfb' backend for inline visualizations."
	else
		elog "For Jupyter notebook support, enable the 'jupyter' USE flag:"
		elog "  echo 'dev-python/vispy jupyter' >> /etc/portage/package.use"
	fi
	elog ""
	elog "Graphics requirements:"
	elog "  - OpenGL 2.1+ capable graphics driver"
	elog "  - Recent graphics card (< 12 years old recommended)"
	elog ""
	elog "To test your installation, run:"
	elog "  python -c 'import vispy; vispy.test()'"

	if ! use opengl; then
		ewarn "You have disabled OpenGL support. VisPy requires an OpenGL"
		ewarn "backend to function. Please enable the 'opengl' USE flag"
		ewarn "and install at least one supported backend."
	fi
}

# Restrict tests for live ebuild as they may be unstable
RESTRICT="test"
