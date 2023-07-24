# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="print full --help when a incorrect command is used"
HOMEPAGE="https://github.com/jakeogh/click-auto-help"
EGIT_REPO_URI="/home/sysskel/myapps/click-auto-help https://github.com/jakeogh/click-auto-help.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

python_install_ll() {
	distutils-r1_python_install_all
}

