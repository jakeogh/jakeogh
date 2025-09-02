# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
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

# Use python_gen_cond_dep only for vtk, with proper PYTHON_USEDEP
RDEPEND="
	$(python_gen_cond_dep '
		sci-libs/vtk[python,imaging,rendering,views,python_single_target_'${PYTHON_SINGLE_TARGET}']
	')
	dev-python/numpy[${PYTHON_USEDEP}]
	>dev-python/matplotlib-3.0.1[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pooch[${PYTHON_USEDEP}]
	>=dev-python/scooby-0.5.1[${PYTHON_USEDEP}]
	jupyter? (
		dev-python/ipyvtklink[${PYTHON_USEDEP}]
		dev-python/pythreejs[${PYTHON_USEDEP}]
		dev-python/jupyterlab-ipywidgets[${PYTHON_USEDEP}]
		dev-python/jupyter-server-proxy[${PYTHON_USEDEP}]
		dev-python/nest_asyncio[${PYTHON_USEDEP}]
		dev-python/panel[${PYTHON_USEDEP}]
	)
	trame? (
		>=dev-python/trame-server-2.11.7[${PYTHON_USEDEP}]
		>=dev-python/trame-client-2.10.0[${PYTHON_USEDEP}]
		>=dev-python/trame-vtk-2.5.8[${PYTHON_USEDEP}]
		>=dev-python/trame-2.5.2[${PYTHON_USEDEP}]
		>=dev-python/trame-vuetify-2.3.1[${PYTHON_USEDEP}]
	)
"

DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
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

