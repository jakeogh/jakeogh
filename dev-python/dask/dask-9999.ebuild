# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Task scheduling and blocked algorithms for parallel processing"
HOMEPAGE="https://dask.org/"
EGIT_REPO_URI="https://github.com/dask/dask.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="distributed test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/cloudpickle-0.2.1[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.11[${PYTHON_USEDEP}]
	>=dev-python/pandas-0.23.4[${PYTHON_USEDEP}]
	>=dev-python/partd-0.3.8[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	>=dev-python/toolz-0.7.3[${PYTHON_USEDEP}]
	distributed? (
		>=dev-python/distributed-1.16[${PYTHON_USEDEP}]
		>=dev-python/s3fs-0.0.8[${PYTHON_USEDEP}]
	)
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/toolz[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/numexpr[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		sci-libs/scipy[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-0.18.2-skip-broken-test.patch"
)

python_test() {
	pytest -v dask || die
}
