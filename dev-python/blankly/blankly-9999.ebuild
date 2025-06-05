# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1

#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="build, backtest and deploy your algo"
HOMEPAGE="https://github.com/jakeogh/blankly"
EGIT_REPO_URI="/home/sysskel/myapps/blankly https://github.com/jakeogh/blankly.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/python-binance[${PYTHON_USEDEP}]
	dev-python/newnewtulipy[${PYTHON_USEDEP}]
	dev-python/bokeh[${PYTHON_USEDEP}]
	dev-python/alpaca-trade-api-python[${PYTHON_USEDEP}]
	dev-python/yaspin[${PYTHON_USEDEP}]
	dev-python/questionary[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

