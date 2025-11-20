# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Pytest plugin to randomly order tests and control random.seed"
HOMEPAGE="https://github.com/pytest-dev/pytest-randomly"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pytest-dev/pytest-randomly.git"
else
	SRC_URI="https://github.com/pytest-dev/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-python/pytest-7.0.0[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/factory-boy[${PYTHON_USEDEP}]
		dev-python/faker[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		tests/test_pytest_randomly.py::test_entrypoint_injection
	)
	epytest
}
