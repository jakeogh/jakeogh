# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Observable typed attributes for Python classes"
HOMEPAGE="
	https://github.com/enthought/traits
	https://docs.enthought.com/traits/
	https://pypi.org/project/traits/
"

EGIT_REPO_URI="https://github.com/enthought/traits.git"

LICENSE="BSD"
SLOT="0"
IUSE="doc examples test"

RESTRICT="!test? ( test )"

RDEPEND=""

BDEPEND="
	test? (
		dev-python/cython[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/flake8-ets[${PYTHON_USEDEP}]
		dev-python/mypy[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pyface[${PYTHON_USEDEP}]
		dev-python/pyside6[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/traitsui[${PYTHON_USEDEP}]
	)
	doc? (
		dev-python/enthought-sphinx-theme[${PYTHON_USEDEP}]
		>=dev-python/sphinx-2.1.0[${PYTHON_USEDEP}]
		dev-python/sphinx-copybutton[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest
distutils_enable_sphinx docs \
	dev-python/enthought-sphinx-theme \
	dev-python/sphinx-copybutton

src_prepare() {
	# Remove bundled C extension if building from source
	# The package includes a pre-compiled C extension
	distutils-r1_src_prepare
}

python_configure_all() {
	# Set up any global configuration
	mydistutilsargs=()
}

python_compile() {
	# Build the C extension module
	distutils-r1_python_compile
}

python_compile_all() {
	# Build documentation if requested
	if use doc; then
		build_sphinx docs
	fi
}

python_test() {
	# Run the test suite
	cd "${S}" || die
	"${EPYTHON}" -m unittest discover -s traits -p "*test*.py" || die "Tests failed with ${EPYTHON}"
}

python_install_all() {
	# Install documentation
	if use doc; then
		local HTML_DOCS=( docs/_build/html/. )
	fi

	# Install examples
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi

	distutils-r1_python_install_all
}

pkg_postinst() {
	elog "Traits is a foundational component of the Enthought Tool Suite."
	elog "It provides observable, typed attributes for Python classes."
	elog ""
	elog "Optional runtime dependencies:"
	elog "  - dev-python/numpy: for array trait types"
	elog "  - dev-python/traitsui: for GUI views"
	elog "  - dev-python/pyface: for enhanced GUI support"
	elog ""
	elog "For complete documentation, visit:"
	elog "  https://docs.enthought.com/traits/"
}
