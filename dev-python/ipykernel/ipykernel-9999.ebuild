# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1
inherit git-r3

DESCRIPTION="IPython Kernel for Jupyter"
HOMEPAGE="https://github.com/ipython/ipykernel"
EGIT_REPO_URI="https://github.com/ipython/ipykernel.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	>=dev-python/ipython-6[${PYTHON_USEDEP}]
	dev-python/jupyter_client[${PYTHON_USEDEP}]
	>=dev-python/traitlets-4.1.0[${PYTHON_USEDEP}]
	>=www-servers/tornado-4.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/nose_warnings_filters[${PYTHON_USEDEP}]
		dev-python/flaky[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
