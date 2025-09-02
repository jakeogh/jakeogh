# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
DISTUTILS_USE_PEP517="hatchling"
inherit distutils-r1 git-r3

DESCRIPTION="Parametric objects for Python, enabling parameters with type and range checking, documentation, and dynamic values"
HOMEPAGE="https://param.holoviz.org"
EGIT_REPO_URI="https://github.com/holoviz/param.git"
EGIT_BRANCH="main"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

# Runtime dependencies
RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
"

# Optional: docs and tests
DEPEND="
	${RDEPEND}
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
		dev-python/nbsphinx[${PYTHON_USEDEP}]
		dev-python/jupyter-sphinx[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/flaky[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
	)
"

RESTRICT="!test? ( test )"

python_prepare_all() {
	# Clean any leftover metadata
	rm -rf src/param.egg-info/ 2>/dev/null || true
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	elog "param successfully installed!"
	elog "Try it: python -c 'import param; print(param.__version__)'"
	elog "Documentation: https://param.holoviz.org"
	if use doc; then
		elog "Documentation build dependencies were installed"
	fi
	if use test; then
		elog "Test dependencies were installed"
	fi
}

