# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="The pyface project contains a toolkit-independent GUI abstraction layer"
HOMEPAGE="
	https://github.com/enthought/pyface
	https://pypi.org/project/pyface/
"
EGIT_REPO_URI="https://github.com/enthought/pyface.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	>=dev-python/traits-6.2[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/packaging[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-qt[${PYTHON_USEDEP}]
	)
"

IUSE="examples qt5 wx"

PDEPEND="
	qt5? (
		>=dev-python/PyQt5-5.15[${PYTHON_USEDEP}]
		>=dev-python/pygments-1.6[${PYTHON_USEDEP}]
	)
	wx? (
		>=dev-python/wxpython-4.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	local -x QT_QPA_PLATFORM=offscreen

	# Skip tests that require display
	local EPYTEST_DESELECT=(
		pyface/tests/test_application.py
		pyface/tests/test_gui.py
	)

	epytest
}

python_install_all() {
	distutils-r1_python_install_all

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}

