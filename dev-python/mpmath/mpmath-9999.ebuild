# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 eutils
inherit git-r3

DESCRIPTION="Python library for arbitrary-precision floating-point arithmetic"
HOMEPAGE="http://mpmath.org/"
EGIT_REPO_URI="https://github.com/fredrik-johansson/mpmath.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

IUSE="gmp matplotlib test"
RESTRICT="!test? ( test )"

RDEPEND="
	gmp? ( dev-python/gmpy )
	matplotlib? ( dev-python/matplotlib[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_prepare_all() {
#	local PATCHES=(
#		"${FILESDIR}/${P}.patch"
#		)

	# this test requires X
	rm ${PN}/tests/test_visualization.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	pushd ${PN}/tests >/dev/null
	${EPYTHON} runtests.py -local
	popd >/dev/null
}
