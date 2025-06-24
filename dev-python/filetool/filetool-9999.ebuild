# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1
distutils_enable_tests pytest

DESCRIPTION="common file operatons"
HOMEPAGE="https://github.com/jakeogh/filetool"
EGIT_REPO_URI="https://github.com/jakeogh/filetool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

BDEPEND="
    dev-python/pytest[${PYTHON_USEDEP}]
"

python_test() {
	cd "${S}" || die
    #cd "${BUILD_DIR}/${P}" || die
    epytest tests
}
