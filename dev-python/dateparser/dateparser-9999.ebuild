# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="python parser for human readable dates"
HOMEPAGE="https://github.com/scrapinghub/dateparser"
EGIT_REPO_URI="/home/cfg/_myapps/dateparser https://github.com/scrapinghub/dateparser.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-python/tzlocal
	dev-python/ruamel-yaml
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

