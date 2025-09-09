# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Traits-capable windowing framework"
HOMEPAGE="
	https://github.com/enthought/traitsui
	https://docs.enthought.com/traitsui/
	https://pypi.org/project/traitsui/
"
EGIT_REPO_URI="https://github.com/enthought/traitsui.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="examples pyside2 pyside6 pyqt5 pyqt6 wx test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/pyface-8.0[${PYTHON_USEDEP}]
	dev-python/traits[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	pyside2? (
		dev-python/PySide2[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
	)
	pyside6? (
		dev-python/PySide6[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
	)
	pyqt5? (
		dev-python/PyQt5[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
	)
	pyqt6? (
		dev-python/pyqt6[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
	)
	wx? (
		dev-python/wxpython[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
	)
	examples? (
		dev-python/apptools[${PYTHON_USEDEP}]
		dev-python/chaco[${PYTHON_USEDEP}]
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
	)
"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/packaging[${PYTHON_USEDEP}]
		|| (
			pyside2? ( dev-python/PySide2[${PYTHON_USEDEP}] )
			pyside6? ( dev-python/PySide6[${PYTHON_USEDEP}] )
			pyqt5? ( dev-python/PyQt5[${PYTHON_USEDEP}] )
			pyqt6? ( dev-python/pyqt6[${PYTHON_USEDEP}] )
			wx? ( dev-python/wxpython[${PYTHON_USEDEP}] )
		)
	)
"

REQUIRED_USE="
	|| ( pyside2 pyside6 pyqt5 pyqt6 wx )
	test? ( || ( pyside2 pyside6 pyqt5 pyqt6 wx ) )
"

distutils_enable_tests unittest

python_prepare_all() {
	# Remove bundled dependencies if any
	rm -rf traitsui/qt4/ || die

	distutils-r1_python_prepare_all
}

python_test() {
	# Set up environment for GUI testing
	local toolkit
	if use pyside6; then
		toolkit="qt4"
		export QT_API="pyside6"
	elif use pyside2; then
		toolkit="qt4"
		export QT_API="pyside2"
	elif use pyqt6; then
		toolkit="qt4"
		export QT_API="pyqt6"
	elif use pyqt5; then
		toolkit="qt4"
		export QT_API="pyqt5"
	elif use wx; then
		toolkit="wx"
	else
		toolkit="null"
	fi

	export ETS_TOOLKIT="${toolkit}"

	# Run tests with unittest discovery
	"${EPYTHON}" -m unittest discover -v traitsui/tests || die "Tests failed with ${EPYTHON}"
}

pkg_postinst() {
	elog "TraitsUI provides a toolkit-independent GUI abstraction layer."
	elog "You need to enable at least one GUI toolkit USE flag:"
	elog "  pyside2, pyside6, pyqt5, pyqt6, or wx"
	elog ""
	elog "For examples and demos, enable the 'examples' USE flag."
	elog ""
	elog "Set the ETS_TOOLKIT environment variable to choose your preferred toolkit:"
	elog "  export ETS_TOOLKIT=qt4  # for Qt-based toolkits"
	elog "  export ETS_TOOLKIT=wx   # for wxPython"
	elog ""
	elog "Also set QT_API for Qt toolkits:"
	elog "  export QT_API=pyside6   # for PySide6"
	elog "  export QT_API=pyside2   # for PySide2"
	elog "  export QT_API=pyqt6     # for pyqt6"
	elog "  export QT_API=pyqt5     # for PyQt5"
}


