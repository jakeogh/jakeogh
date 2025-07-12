# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Quickly and accurately render even the largest data"
HOMEPAGE="https://github.com/holoviz/datashader"
EGIT_REPO_URI="https://github.com/holoviz/datashader.git"


LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""


RDEPEND="
    >=dev-python/numpy-1.16[${PYTHON_USEDEP}]
    >=dev-python/pandas-0.25[${PYTHON_USEDEP}]
    >=dev-python/dask-2.0[${PYTHON_USEDEP}]
    >=dev-python/xarray-0.10[${PYTHON_USEDEP}]
    >=dev-python/numba-0.40[${PYTHON_USEDEP}]
    >=dev-python/pyct-0.4.4[${PYTHON_USEDEP}]
    >=dev-python/colorcet-2.0.1[${PYTHON_USEDEP}]
    >=dev-python/param-1.9.3[${PYTHON_USEDEP}]
    dev-python/python-dateutil[${PYTHON_USEDEP}]
    dev-python/pyproj[${PYTHON_USEDEP}]
"

BDEPEND="
    dev-python/setuptools[${PYTHON_USEDEP}]
    dev-python/wheel[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

