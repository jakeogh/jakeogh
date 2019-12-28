# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1
inherit git-r3

DESCRIPTION="IPython HTML widgets for Jupyter"
HOMEPAGE="https://ipywidgets.readthedocs.io/"
EGIT_REPO_URI="https://github.com/jupyter-widgets/ipywidgets.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/ipykernel-4.5.1[${PYTHON_USEDEP}]
	>=dev-python/nbformat-4.2.0[${PYTHON_USEDEP}]
	>=dev-python/traitlets-4.3.1[${PYTHON_USEDEP}]
	>=dev-python/widgetsnbextension-3.0.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	test? (
		$(python_gen_cond_dep 'dev-python/mock[${PYTHON_USEDEP}]' 'python2*')
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
	)
"

python_test() {
	nosetests --with-coverage --cover-package=ipywidgets ipywidgets || die
}
