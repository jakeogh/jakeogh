# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..11} )
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml
DISTUTILS_USE_PEP517=poetry

inherit git-r3
inherit distutils-r1

DESCRIPTION="A high-performance algorithmic trading platform and event-driven backtester"
HOMEPAGE="https://github.com/jakeogh/nautilus-trader"
EGIT_REPO_URI="/home/cfg/_myapps/nautilus-trader https://github.com/jakeogh/nautilus-trader.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/fsspec[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"
