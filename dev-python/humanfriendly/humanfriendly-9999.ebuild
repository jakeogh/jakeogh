# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1 git-r3

MY_PN="python-${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Human friendly output for text interfaces using Python"
HOMEPAGE="https://pypi.org/project/humanfriendly/ https://humanfriendly.readthedocs.org"
EGIT_REPO_URI="https://github.com/xolox/python-humanfriendly.git"

SLOT="0"
LICENSE="MIT"
KEYWORDS=""
IUSE="test"

RDEPEND="
	dev-python/monotonic[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		>=dev-python/capturer-2.1[${PYTHON_USEDEP}]
		>=dev-python/coloredlogs-2.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-3.0.7[${PYTHON_USEDEP}]
	)
	"

#S="${WORKDIR}/${MY_P}"

python_test() {
	pytest -v || die
}
