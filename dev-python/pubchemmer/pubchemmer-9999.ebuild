# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="pubchem postgresql import and search"
HOMEPAGE="https://github.com/jakeogh/pubchemmer"
EGIT_REPO_URI="https://github.com/jakeogh/pubchemmer.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]

	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/structure-data-file-sdf-parser[${PYTHON_USEDEP}]
	dev-python/sqlalchemytool[${PYTHON_USEDEP}]
	sci-chemistry/openbabel[python]
	dev-db/postgresql:*
"

DEPEND="${RDEPEND}"
