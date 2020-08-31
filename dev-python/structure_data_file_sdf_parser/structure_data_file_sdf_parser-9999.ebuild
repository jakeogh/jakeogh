# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Read (chemical) Structure Data Files"
HOMEPAGE="https://github.com/jakeogh/structure_data_file_sdf_parser"
EGIT_REPO_URI="/home/cfg/_myapps/structure_data_file_sdf_parser https://github.com/jakeogh/structure_data_file_sdf_parser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	sci-chemistry/openbabel
	sys-fs/archivemount
"

DEPEND="${RDEPEND}"
