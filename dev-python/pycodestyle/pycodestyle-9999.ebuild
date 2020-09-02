# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy{,3} python2_7 python3_{7..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Python style guide checker (fka pep8)"
HOMEPAGE="https://pypi.org/project/pycodestyle/"
EGIT_REPO_URI="https://github.com/PyCQA/pycodestyle.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx )
"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	PYTHONPATH="${S}" "${PYTHON}" pycodestyle.py -v --statistics pycodestyle.py || die
	PYTHONPATH="${S}" "${PYTHON}" pycodestyle.py -v --max-doc-length=72 --testsuite=testsuite || die
	PYTHONPATH="${S}" "${PYTHON}" pycodestyle.py --doctest -v || die
	esetup.py test
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
