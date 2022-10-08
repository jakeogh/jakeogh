# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1

#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="Python client for Alpaca's trade API"
HOMEPAGE="https://github.com/jakeogh/alpaca-trade-api-python"
EGIT_REPO_URI="/home/cfg/_myapps/alpaca-trade-api-python https://github.com/jakeogh/alpaca-trade-api-python.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"


python_prepare_all() {
	sed -i "s/'pytest-runner'\(,\)\?//" setup.py || die
	distutils-r1_python_prepare_all
}

#src_prepare() {
#	default
#	xdg_src_prepare
#}
