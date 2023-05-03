# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Common humanization utilities"
HOMEPAGE="https://github.com/jmoiron/humanize/"

# Tests are not included in PyPI tarballs
# https://github.com/jmoiron/humanize/issues/33
EGIT_REPO_URI="https://github.com/jmoiron/humanize.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc test"
RESTRICT="!test? ( test )"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/mock[${PYTHON_USEDEP}] )
"

python_compile_all() {
	if use doc; then
		cd docs || die
		sphinx-build . _build/html || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	esetup.py test || die "tests failed with ${EPYTHON}"
}
