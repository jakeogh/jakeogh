# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="N-D labeled arrays and datasets in Python"
HOMEPAGE="http://xarray.pydata.org/"
EGIT_REPO_URI="https://github.com/pydata/xarray.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/numpy-1.14[${PYTHON_USEDEP}]
	>=dev-python/pandas-0.19.2[${PYTHON_USEDEP}]"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		>=dev-python/dask-0.18.2[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		>=sci-libs/scipy-1.1[${PYTHON_USEDEP}]
	)"

PATCHES=(
	"${FILESDIR}/${PN}-0.10.8-skip-broken-test.patch"
)

python_test() {
	pytest -v || die
}
