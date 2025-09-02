# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3

DESCRIPTION="Python code toolkit: utilities for developing and packaging Python code"
HOMEPAGE="https://github.com/holoviz-dev/pyct"
EGIT_REPO_URI="https://github.com/holoviz-dev/pyct.git"
EGIT_BRANCH="main"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# Runtime dependencies
RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/entrypoints[${PYTHON_USEDEP}]
"

# Optional: test dependencies
DEPEND="
	${RDEPEND}
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/flaky[${PYTHON_USEDEP}]
	)
"

# No test phase by default (upstream tests require network or are not suitable for live builds)
RESTRICT="!test? ( test )"

python_prepare_all() {
	# Clean any leftover metadata
	rm -rf src/pyct.egg-info/ 2>/dev/null || true
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	elog "pyct successfully installed!"
	elog "Try it: python -c 'from pyct import ensure_module; print(ensure_module(\"os\"))'"
	elog "Documentation: https://github.com/holoviz-dev/pyct"
	if use test; then
		elog "Test dependencies were installed"
	fi
}

