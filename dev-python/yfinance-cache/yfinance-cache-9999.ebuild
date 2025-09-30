# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3 distutils-r1

DESCRIPTION="Intelligent caching wrapper for yfinance module"
HOMEPAGE="https://github.com/ValueRaider/yfinance-cache"
EGIT_REPO_URI="https://github.com/ValueRaider/yfinance-cache.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
    dev-python/pulp[${PYTHON_USEDEP}]
"
