# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

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
"
RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
