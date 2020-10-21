# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1 eutils git-r3

DESCRIPTION="Python code static checker"
HOMEPAGE="https://www.logilab.org/project/pylint
	https://pypi.org/project/pylint/
	https://github.com/pycqa/pylint"
EGIT_REPO_URI="https://github.com/pycqa/pylint.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc examples test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/astroid-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/isort-4.2.5[${PYTHON_USEDEP}]
	dev-python/mccabe[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( ${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
	)"

#PATCHES=(
#	"${FILESDIR}/${PN}-2.3.1-sphinx-theme.patch"
#	"${FILESDIR}/${PN}-2.3.1-no-pytest-runner.patch"
#)

python_compile_all() {
	# selection of straight html triggers a trivial annoying bug, we skirt it
	use doc && PYTHONPATH="${S}" emake -e -C doc singlehtml
}

python_test() {
	${EPYTHON} -m pytest -v pylint/test/ || die "tests failed"
}

python_install_all() {
	doman man/{pylint,pyreverse}.1
	if use examples ; then
		docinto examples
		dodoc -r examples/.
	fi
	use doc && local HTML_DOCS=( doc/_build/singlehtml/. )
	distutils-r1_python_install_all
}

pkg_postinst() {
	# Optional dependency on "tk" USE flag would break support for Jython.
	optfeature "pylint-gui script requires dev-lang/python with \"tk\" USE flag enabled." 'dev-lang/python[tk]'
}
