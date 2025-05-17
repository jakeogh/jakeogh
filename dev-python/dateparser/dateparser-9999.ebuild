# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="python parser for human readable dates"
HOMEPAGE="https://github.com/scrapinghub/dateparser"
EGIT_REPO_URI="/home/sysskel/myapps/dateparser https://github.com/scrapinghub/dateparser.git"

LICENSE=""
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-python/ruamel-yaml
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

