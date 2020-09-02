# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{7..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Appendable key-value storage"
HOMEPAGE="https://github.com/dask/partd/"
EGIT_REPO_URI="https://github.com/dask/partd.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/locket[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/blosc[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pyzmq[${PYTHON_USEDEP}]
		dev-python/toolz[${PYTHON_USEDEP}]
	)"

python_test() {
	py.test partd --verbose || die
}
