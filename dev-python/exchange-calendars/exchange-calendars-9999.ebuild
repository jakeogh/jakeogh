# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Calendars for various securities exchanges"
HOMEPAGE="https://github.com/gerrymanoim/exchange_calendars"
EGIT_REPO_URI="https://github.com/gerrymanoim/exchange_calendars.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/pyluach[${PYTHON_USEDEP}]
	dev-python/toolz[${PYTHON_USEDEP}]
	dev-python/tzdata[${PYTHON_USEDEP}]
	dev-python/korean-lunar-calendar[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
