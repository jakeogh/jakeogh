# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Application tools from the Enthought Tool Suite"
HOMEPAGE="
	https://docs.enthought.com/apptools/
	https://github.com/enthought/apptools/
	https://pypi.org/project/apptools/
"

EGIT_REPO_URI="https://github.com/enthought/apptools.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="+gui h5 persistence preferences test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/traits-6.2.0[${PYTHON_USEDEP}]
	gui? (
		>=dev-python/pyface-6.0.0[${PYTHON_USEDEP}]
		>=dev-python/traitsui-6.0.0[${PYTHON_USEDEP}]
		>=dev-python/envisage-4.0.0[${PYTHON_USEDEP}]
	)
	h5? (
		>=dev-python/numpy-1.6[${PYTHON_USEDEP}]
		>=dev-python/pandas-0.15[${PYTHON_USEDEP}]
		>=dev-python/tables-3.1[${PYTHON_USEDEP}]
	)
	persistence? (
		>=dev-python/numpy-1.6[${PYTHON_USEDEP}]
	)
	preferences? (
		>=dev-python/configobj-5.0[${PYTHON_USEDEP}]
	)
"

BDEPEND="
	test? (
		${RDEPEND}
		>=dev-python/coverage-4.0[${PYTHON_USEDEP}]
		>=dev-python/mock-1.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest

python_test() {
	cd "${BUILD_DIR}" || die
	eunittest discover -v -s "${S}/apptools" -p "*test*.py" || die "Tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all

	# Install documentation
	if use doc; then
		dodoc -r docs/build/html
	fi

	# Install examples
	dodoc -r examples
}

pkg_postinst() {
	elog "AppTools is a collection of Python packages from Enthought."
	elog ""
	elog "Optional features and their USE flags:"
	elog "  gui         - Install PyFace, TraitsUI, and Envisage for GUI support"
	elog "  h5          - Install NumPy, Pandas, and PyTables for HDF5 I/O support"
	elog "  persistence - Install NumPy for object persistence support"
	elog "  preferences - Install ConfigObj for application preferences support"
	elog ""
	elog "For more information, visit:"
	elog "  https://docs.enthought.com/apptools/"
}
