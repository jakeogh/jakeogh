# Copyright 2020 Gentoo Authors
# Distributed under the terms of the BSD license

EAPI=7

PYTHON_COMPAT=( python3_{7,8} pypy{,3} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Annotate Python AST's."
HOMEPAGE="https://github.com/gristlabs/asttokens"
EGIT_REPO_URI="https://github.com/gristlabs/asttokens.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pycodestyle[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	test? (
		  dev-python/coverage[${PYTHON_USEDEP}]
		  dev-python/nose[${PYTHON_USEDEP}]
		  dev-python/astroid[${PYTHON_USEDEP}]
	)
"

python_test() {
	py.test -v || die "Tests fail with ${EPYTHON}"
}
