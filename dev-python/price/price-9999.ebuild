# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="get prices"
HOMEPAGE="https://github.com/jakeogh"
EGIT_REPO_URI="/home/cfg/_myapps/price"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/financial-data
dev-python/pandas-datareader
sci-libs/scikits_learn
"

RDEPEND="
	${DEPEND}
"

python_install_all() {
	local DOCS=( README.md )
	distutils-r1_python_install_all
}
