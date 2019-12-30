# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Python client for the Prometheus monitoring system"
HOMEPAGE="https://pypi.org/project/prometheus_client/"
EGIT_REPO_URI="https://github.com/prometheus/client_python.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

S=${WORKDIR}/client_python-${PV}

RDEPEND="|| ( dev-python/twisted[${PYTHON_USEDEP}] dev-python/twisted-web[${PYTHON_USEDEP}] )"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	pytest -v || die
}
