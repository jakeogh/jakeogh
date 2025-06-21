# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="Converting Jupyter Notebooks"
HOMEPAGE="https://nbconvert.readthedocs.io/"
EGIT_REPO_URI="https://github.com/jupyter/nbconvert.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc test"

RDEPEND="
	dev-python/bleach[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	>=dev-python/entrypoints-0.2.2[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/jupyter_core[${PYTHON_USEDEP}]
	>=dev-python/mistune-0.7.4[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
	>=dev-python/pandocfilters-1.4.1[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	>=dev-python/traitlets-4.2.1[${PYTHON_USEDEP}]
	dev-python/testpath[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-python/jupyter_client[${PYTHON_USEDEP}]
		dev-python/nbsphinx[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
	)
	test? (
		${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/ipykernel[${PYTHON_USEDEP}]
		>=dev-python/jupyter_client-4.2[${PYTHON_USEDEP}]
	)
"

# still failing in many places
RESTRICT=test

python_prepare_all() {
	# Prevent un-needed download during build
	if use doc; then
		sed -e "/^    'sphinx.ext.intersphinx',/d" -i docs/source/conf.py || die
	fi
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		emake -C docs html
		HTML_DOCS=( docs/build/html/. )
	fi
}

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}"/lib || die
	pytest -v --pyargs nbconvert || die
}

pkg_postinst() {
	if ! has_version app-text/pandoc ; then
		einfo "Pandoc is required for converting to formats other than Python,"
		einfo "HTML, and Markdown. If you need this functionality, install"
		einfo "app-text/pandoc."
	fi
}
