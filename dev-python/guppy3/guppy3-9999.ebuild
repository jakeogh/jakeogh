# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="Guppy 3 -- Guppy-PE ported to Python 3"
HOMEPAGE="https://github.com/zhuyifei1999/guppy3/ https://pypi.org/project/guppy3/"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
EGIT_REPO_URI="https://github.com/zhuyifei1999/guppy3"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	py.test -v -v || die
}

distutils_enable_tests pytest
