# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 virtualx
inherit git-r3

MY_PN="${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="CFFI-based drop-in replacement for Pycairo"
HOMEPAGE="https://github.com/Kozea/cairocffi"
EGIT_REPO_URI="https://github.com/Kozea/cairocffi.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="
	$(python_gen_cond_dep '>=dev-python/cffi-1.1.0:=[${PYTHON_USEDEP}]' 'python*')
	>=dev-python/xcffib-0.3.2[${PYTHON_USEDEP}]
	x11-libs/cairo:0=[xcb]
	x11-libs/gdk-pixbuf[jpeg]
	$(python_gen_cond_dep '>=virtual/pypy-2.6.0' pypy )"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? (
		${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}]
	)
	$(python_gen_cond_dep '>=virtual/pypy-2.6.0' pypy )"

PATCHES=(
	"${FILESDIR}"/${PN}-0.8.0-tests.patch
)
	#"${FILESDIR}"/${PN}-1.0.2-test-deps.patch

S="${WORKDIR}/${MY_P}"

python_compile_all() {
	use doc && esetup.py build_sphinx
}

python_test() {
	virtx py.test -v --pyargs cairocffi
}

python_install_all() {
	use doc && HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
