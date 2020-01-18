# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy python2_7 python3_{7,8} )

inherit distutils-r1
inherit git-r3

MY_PN="Flask-WTF"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple integration of Flask and WTForms"
HOMEPAGE="https://pythonhosted.org/Flask-WTF/ https://pypi.org/project/Flask-WTF/"
EGIT_REPO_URI="https://github.com/ajford/flask-wtf"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/Babel[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/flask-babel[${PYTHON_USEDEP}]
	dev-python/itsdangerous[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	>=dev-python/wtforms-1.0.5[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
	)
	doc? (
		${RDEPEND}
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	sed -i "/'sphinx.ext.intersphinx'/d" docs/conf.py || die
	# tries to access things over the network
	rm tests/test_recaptcha.py || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		sphinx-build docs docs/_build/html || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	nosetests || die "tests failed with ${EPYTHON}"
}
