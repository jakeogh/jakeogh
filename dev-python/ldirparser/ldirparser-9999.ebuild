# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="Parse the CSV output of an Agilent LDIR"
HOMEPAGE="https://github.com/jakeogh/ldirparser"
EGIT_REPO_URI="https://github.com/jakeogh/ldirparser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/csvparser[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
