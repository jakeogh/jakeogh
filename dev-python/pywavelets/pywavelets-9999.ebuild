# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1
inherit git-r3

#MY_PN="${PN/pyw/PyW}"
#MY_P="${MY_PN}-${PV}"
MY_P="${PN}-${PV}"

DESCRIPTION="Discrete Wavelet Transforms in Python"
HOMEPAGE="https://pywavelets.readthedocs.io/en/latest/"
EGIT_REPO_URI="https://github.com/PyWavelets/pywt.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc examples test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
DEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/numpydoc[${PYTHON_USEDEP}] )
	test? (
		${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_P}"

python_test() {
	cd "${BUILD_DIR}"/lib || die
	nosetests -v .
}

python_compile_all() {
	use doc && emake -C doc html
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/html/. )
	distutils-r1_python_install_all
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r demo/*
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
