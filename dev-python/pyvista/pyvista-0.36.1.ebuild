# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 git-r3

DESCRIPTION="Easier Pythonic interface to VTK"
HOMEPAGE="https://docs.pyvista.org"
EGIT_REPO_URI="https://github.com/pyvista/pyvista.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
    sci-libs/vtk[python,imaging,rendering,views,${PYTHON_SINGLE_USEDEP}]
    $(python_gen_cond_dep '
        dev-python/appdirs[${PYTHON_USEDEP}]
        dev-python/imageio[${PYTHON_USEDEP}]
        dev-python/numpy[${PYTHON_USEDEP}]
        dev-python/pillow[${PYTHON_USEDEP}]
    ')
"
        # dev-python/scooby[${PYTHON_USEDEP}]  # Uncomment if needed

DEPEND="${RDEPEND}"







