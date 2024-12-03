# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Read (chemical) Structure Data Files"
HOMEPAGE="https://github.com/jakeogh/structure-data-file-sdf-parser"
EGIT_REPO_URI="/home/sysskel/myapps/structure-data-file-sdf-parser https://github.com/jakeogh/structure-data-file-sdf-parser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/configtool[${PYTHON_USEDEP}]
	sci-chemistry/openbabel
"

DEPEND="${RDEPEND}"
