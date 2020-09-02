# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{7..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A configuration system for Python applications"
HOMEPAGE="https://github.com/ipython/traitlets"
EGIT_REPO_URI="https://github.com/ipython/traitlets.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/decorator[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/enum34[${PYTHON_USEDEP}]' 'python2*')
	dev-python/ipython_genutils[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	"
DEPEND="
	doc? (
		dev-python/ipython_genutils[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
	test? (
		$(python_gen_cond_dep 'dev-python/mock[${PYTHON_USEDEP}]' 'python2*')
		dev-python/pytest[${PYTHON_USEDEP}]
		)
	"

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
	pytest -vv traitlets || die
}
