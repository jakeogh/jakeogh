# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="Download market data from Yahoo Finance API"
HOMEPAGE="https://github.com/ranaroussi/yfinance"
EGIT_REPO_URI="https://github.com/ranaroussi/yfinance.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/multitasking[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/python-frozendict[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/peewee[${PYTHON_USEDEP}]
	dev-python/requests-cache[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/curl-cffi[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

distutils_enable_tests pytest

pkg_setup() {
	# Warn users about the unofficial nature of this package
	ewarn "yfinance is not affiliated, endorsed, or vetted by Yahoo, Inc."
	ewarn "It is an open-source tool intended for research and educational purposes."
}
