# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 git-r3

DESCRIPTION="pubchem postgresql import and search"
HOMEPAGE="https://github.com/jakeogh/pubchemmer"
EGIT_REPO_URI="/home/cfg/_myapps/pubchemmer https://github.com/jakeogh/pubchemmer.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/structure_data_file_sdf_parser[${PYTHON_USEDEP}]
	sci-chemistry/openbabel[python]
	dev-db/postgresql:*
"

DEPEND="${RDEPEND}"
