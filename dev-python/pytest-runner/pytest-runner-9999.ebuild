# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{7..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Adds support for tests during installation of setup.py files"
HOMEPAGE="https://pypi.org/project/pytest-runner/ https://github.com/pytest-dev/pytest-runner"
EGIT_REPO_URI="https://github.com/pytest-dev/pytest-runner.git"

LICENSE="MIT"
KEYWORDS=""
SLOT="0"
IUSE="test"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"
DEPEND="
	>=dev-python/setuptools-40.6.3[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	doc? (
		dev-python/jaraco-packaging[${PYTHON_USEDEP}]
		dev-python/rst-linker[${PYTHON_USEDEP}]
	)
	test? ( ${RDEPEND} )
"

distutils_enable_sphinx docs

# Tests require network access to download packages
RESTRICT="test"

python_test() {
	esetup.py pytest
}
