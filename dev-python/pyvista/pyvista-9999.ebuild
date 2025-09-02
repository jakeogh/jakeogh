# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Only support one Python version to match sci-libs/vtk
PYTHON_COMPAT=( python3_13 )  # Change to match your system
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3

DESCRIPTION="Easier Pythonic interface to VTK"
HOMEPAGE="https://docs.pyvista.org"
EGIT_REPO_URI="https://github.com/pyvista/pyvista.git"
EGIT_BRANCH="main"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jupyter trame"

# DO NOT use ${PYTHON_USEDEP} in RDEPEND
# Use raw USEDEP expansion via USE_PYTHON_SINGLE_IMPL=1
RDEPEND="
	sci-libs/vtk[python,imaging,rendering,views,python_single_target_${PYTHON_SINGLE_TARGET}]
	dev-python/numpy
	>dev-python/matplotlib-3.0.1
	dev-python/pillow
	dev-python/pooch
	>=dev-python/scooby-0.5.1
	jupyter? (
		dev-python/ipyvtklink
		dev-python/pythreejs
		dev-python/jupyterlab-ipywidgets
		dev-python/jupyter-server-proxy
		dev-python/nest_asyncio
		dev-python/panel
	)
	trame? (
		>=dev-python/trame-server-2.11.7
		>=dev-python/trame-client-2.10.0
		>=dev-python/trame-vtk-2.5.8
		>=dev-python/trame-2.5.2
		>=dev-python/trame-vuetify-2.3.1
	)
"

DEPEND="
	${RDEPEND}
	dev-python/setuptools
	dev-python/setuptools_scm
	dev-python/wheel
"

RESTRICT="test"

python_prepare_all() {
	rm -rf src/pyvista.egg-info/ 2>/dev/null || true
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	elog "pyvista successfully installed!"
	elog "Try it: python -c 'from pyvista import examples; examples.download_st_helens().plot()'"
	elog "Documentation: https://docs.pyvista.org"
}

