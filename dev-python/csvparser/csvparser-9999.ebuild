# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="Parse csv into dict"
HOMEPAGE="https://github.com/jakeogh/csvparser"
EGIT_REPO_URI="https://github.com/jakeogh/csvparser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/csvsort[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
