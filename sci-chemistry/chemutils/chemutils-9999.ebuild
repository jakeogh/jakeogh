# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 git-r3

DESCRIPTION="Convenience functions wrapping pubchempy"
HOMEPAGE="https://github.com/ejhonglab/chemutils"
EGIT_REPO_URI="https://github.com/ejhonglab/chemutils.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/pint[${PYTHON_USEDEP}]
	dev-python/xlsxwriter[${PYTHON_USEDEP}]
	dev-python/openpyxl[${PYTHON_USEDEP}]
	sci-chemistry/pubchempy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/openpyxl[${PYTHON_USEDEP}]
"

