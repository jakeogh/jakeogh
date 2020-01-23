# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy{,3} )
PYTHON_REQ_USE="xml(+)"

inherit distutils-r1
inherit git-r3

DESCRIPTION="HTML parser based on the HTML5 specification"
HOMEPAGE="https://github.com/html5lib/html5lib-python/ https://html5lib.readthedocs.org"
EGIT_REPO_URI="https://github.com/html5lib/html5lib-python.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND=">=dev-python/six-1.9[${PYTHON_USEDEP}]
	dev-python/webencodings[${PYTHON_USEDEP}]"
BDEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-expect[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
	)"

RESTRICT+=" !test? ( test )"

PATCHES=(
	# https://github.com/html5lib/html5lib-python/pull/429
	"${FILESDIR}/html5lib-python-1.0.1-support-pytest4.patch"
)

distutils_enable_tests pytest
