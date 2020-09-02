# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{7..9} pypy pypy3 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1
inherit git-r3

DESCRIPTION="Extensions to the Python standard library unit testing framework"
HOMEPAGE="https://github.com/testing-cabal/testtools"
EGIT_REPO_URI="https://github.com/testing-cabal/testtools.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc test"
RESTRICT="!test? ( test )"

CDEPEND="
	>=dev-python/extras-1.0.0[${PYTHON_USEDEP}]
	dev-python/mimeparse[${PYTHON_USEDEP}]
	>=dev-python/pbr-0.11[${PYTHON_USEDEP}]
	dev-python/pyrsistent[${PYTHON_USEDEP}]
	>=dev-python/six-1.4.0[${PYTHON_USEDEP}]
	dev-python/traceback2[${PYTHON_USEDEP}]
	>=dev-python/unittest2-1.0.0[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${CDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? (
		>=dev-python/fixtures-1.3.0[${PYTHON_USEDEP}]
		dev-python/testscenarios[${PYTHON_USEDEP}]
	)
"
RDEPEND="${CDEPEND}"
PDEPEND=">=dev-python/fixtures-1.3.0[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}"/testtools-2.3.0-py37.patch
)

python_compile_all() {
	use doc && emake -C doc html
}

python_test() {
	"${PYTHON}" -m testtools.run testtools.tests.test_suite || die "tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && HTML_DOCS=( doc/_build/html/. )

	distutils-r1_python_install_all
}
