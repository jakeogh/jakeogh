# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="Core common functionality of Jupyter projects"
HOMEPAGE="https://jupyter.org"
EGIT_REPO_URI="https://github.com/jupyter/jupyter_core.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc test"

RDEPEND="dev-python/traitlets[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinxcontrib-github-alt[${PYTHON_USEDEP}] )
	test? ( >=dev-python/ipython-4.0.1[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Prevent un-needed download during build
	if use doc; then
		sed -e "/^    'sphinx.ext.intersphinx',/d" -i docs/conf.py || die
	fi

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		emake -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}"/lib || die
	py.test jupyter_core || die
}
