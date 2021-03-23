# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="python parser for human readable dates"
HOMEPAGE="https://github.com/scrapinghub/dateparser"
EGIT_REPO_URI="https://github.com/scrapinghub/dateparser.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-python/tzlocal
	dev-python/ruamel-yaml
	dev-python/regex[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

#python_install_all() {
#	distutils-r1_python_install_all
#}
