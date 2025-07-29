# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8


PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_SINGLE_IMPL=1  # because "sci-libs/vtk" inherits "python-single-r1"
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Easier Pythonic interface to VTK"
HOMEPAGE="https://docs.pyvista.org"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
RESTRICT="mirror"

# ipyvtkwidgets has ipywidgets pinned to 7.7, which is inconsistent with jupyterlab-widgets
#	jupyter? (
#		$(python_gen_cond_dep '
#			dev-python/ipyvtklink[${PYTHON_USEDEP}]
#			dev-python/pythreejs[${PYTHON_USEDEP}]
#			dev-python/jupyterlab-ipywidgets[${PYTHON_USEDEP}]
#			dev-python/jupyter-server-proxy[${PYTHON_USEDEP}]
#			dev-python/nest_asyncio[${PYTHON_USEDEP}]
#			dev-python/panel[${PYTHON_USEDEP}]
#		')
#	trame? (
#		$(python_gen_cond_dep '
#			>=dev-python/trame-server-2.11.7[${PYTHON_USEDEP}]
#			>=dev-python/trame-client-2.10.0[${PYTHON_USEDEP}]
#			>=dev-python/trame-vtk-2.5.8[${PYTHON_USEDEP}]
#			>=dev-python/trame-2.5.2[${PYTHON_USEDEP}]
#			>=dev-python/trame-vuetify-2.3.1[${PYTHON_USEDEP}]
#		')
#	)

IUSE="jupyter"

RDEPEND="
	sci-libs/vtk[python,imaging,rendering,views,${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/numpy[${PYTHON_USEDEP}]
		>dev-python/matplotlib-3.0.1[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pooch[${PYTHON_USEDEP}]
		>=dev-python/scooby-0.5.1[${PYTHON_USEDEP}]
	')
"

DEPEND="${RDEPEND}"

distutils_enable_tests pytest

