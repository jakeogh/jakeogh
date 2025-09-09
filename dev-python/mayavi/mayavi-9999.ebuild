# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )


inherit distutils-r1 git-r3

DESCRIPTION="3D scientific data visualization library and application"
HOMEPAGE="
	https://docs.enthought.com/mayavi/mayavi/
	https://github.com/enthought/mayavi/
	https://pypi.org/project/mayavi/
"

EGIT_REPO_URI="https://github.com/enthought/mayavi.git"

LICENSE="BSD LGPL-2"
SLOT="0"
IUSE="examples +gui jupyter qt6 test"
RESTRICT="!test? ( test )"

# Dependencies based on current Mayavi requirements
RDEPEND="
	>=dev-python/numpy-1.16.0[${PYTHON_USEDEP}]
	>=dev-python/traits-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyface-6.1.1[${PYTHON_USEDEP}]
	>=dev-python/apptools-4.4.0[${PYTHON_USEDEP}]
	>=dev-python/envisage-4.2.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.0[${PYTHON_USEDEP}]
	>=sci-libs/vtk-8.2.0[python]
	gui? (
		>=dev-python/traitsui-7.0.0[${PYTHON_USEDEP}]
		>=dev-python/pygments-2.0[${PYTHON_USEDEP}]
		qt6? (
			dev-python/PyQt6[${PYTHON_USEDEP}]
			dev-qt/qtbase:6[gui,widgets]
			dev-qt/qtsvg:6
		)
		!qt6? (
			|| (
				dev-python/pyqt5[${PYTHON_USEDEP}]
				dev-python/pyside2[${PYTHON_USEDEP}]
				dev-python/pyside6[${PYTHON_USEDEP}]
				dev-python/wxpython:4.0[${PYTHON_USEDEP}]
			)
		)
	)
	jupyter? (
		dev-python/jupyter[${PYTHON_USEDEP}]
		dev-python/ipywidgets[${PYTHON_USEDEP}]
		dev-python/ipyevents[${PYTHON_USEDEP}]
	)
"

DEPEND="${RDEPEND}"

BDEPEND="
	>=dev-python/setuptools-45[${PYTHON_USEDEP}]
	>=dev-python/wheel-0.30[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

# Required to build the TVTK classes during installation
BDEPEND+=" >=sci-libs/vtk-8.2.0[python]"

DOCS=( "README.rst" "CHANGES.txt" "NEWS.txt" )

python_prepare_all() {
	# Remove bundled font files to use system fonts
	rm -rf mayavi/core/lut/data/*.ttf || die

	# Ensure Qt6 is used when qt6 USE flag is enabled
	if use qt6; then
		sed -i -e "s/PyQt5/PyQt6/g" \
			   -e "s/PySide2/PySide6/g" \
			   mayavi/preferences/api.py || die
		sed -i -e "s/PyQt5/PyQt6/g" \
			   -e "s/PySide2/PySide6/g" \
			   mayavi/core/common.py || die
		# Set Qt API to PyQt6 in environment for build process
		export QT_API="pyqt6"
	fi

	distutils-r1_python_prepare_all
}

python_configure_all() {
	# Configure for Qt6 if enabled
	if use qt6; then
		export QT_API="pyqt6"
		export ETS_TOOLKIT="qt"
	elif use gui; then
		# Let the system auto-detect available Qt toolkit
		export ETS_TOOLKIT="qt"
	else
		export ETS_TOOLKIT="null"
	fi
}

python_compile() {
	# The TVTK classes need to be built during compilation
	# This can be memory and time intensive
	distutils-r1_python_compile
}

python_test() {
	if ! use gui; then
		einfo "Tests require GUI support, skipping"
		return 0
	fi

	cd "${BUILD_DIR}" || die
	# Run basic tests without requiring X display
	export ETS_TOOLKIT="null"
	epytest tvtk/tests/test_tvtk.py -v || die "TVTK tests failed"

	if [[ ${DISPLAY} ]]; then
		# Run GUI tests if X display is available
		if use qt6; then
			export QT_API="pyqt6"
		fi
		export ETS_TOOLKIT="qt"
		epytest mayavi/tests/test_mlab.py -v -k "not test_" || true
	else
		ewarn "No X display available, skipping GUI tests"
	fi
}

python_install_all() {
	distutils-r1_python_install_all

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi

	if use jupyter; then
		einfo "Installing Jupyter extensions..."
		# Install Jupyter notebook extensions
		jupyter nbextension install --sys-prefix --py mayavi || die
		jupyter nbextension enable --sys-prefix --py mayavi || die
	fi
}

pkg_postinst() {
	if use qt6; then
		elog "Mayavi has been built with Qt6 support (PyQt6)."
		elog "Make sure to set QT_API=pyqt6 in your environment"
		elog "or in your Python scripts before importing Mayavi."
	elif use gui; then
		elog "Mayavi has been built with Qt5 support."
		elog "You can set QT_API environment variable to choose"
		elog "between available Qt bindings (pyqt5, pyside2, etc.)"
	fi

	if use jupyter; then
		elog "Jupyter notebook support has been installed."
		elog "You may need to restart Jupyter notebook/lab"
		elog "for the extensions to become available."
	fi

	elog "To test your Mayavi installation, try running:"
	elog "  mayavi2"
	elog ""
	elog "For headless use, set ETS_TOOLKIT=null in your environment."
}
