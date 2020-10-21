# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1
inherit git-r3

DESCRIPTION="Jupyter protocol implementation and client libraries"
HOMEPAGE="https://jupyter.org"
EGIT_REPO_URI="https://github.com/jupyter/jupyter_client.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/traitlets[${PYTHON_USEDEP}]
	dev-python/jupyter_core[${PYTHON_USEDEP}]
	>=dev-python/pyzmq-14.4.0[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}
	test? ( dev-python/ipykernel[${PYTHON_USEDEP}]
			dev-python/ipython[${PYTHON_USEDEP}]
			dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_test() {
	pytest -vv jupyter_client || die
}
