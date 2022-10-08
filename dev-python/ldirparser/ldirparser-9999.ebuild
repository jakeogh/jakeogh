# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Parse the CSV output of an Agilent LDIR"
HOMEPAGE="https://github.com/jakeogh/ldirparser"
EGIT_REPO_URI="/home/cfg/_myapps/ldirparser https://github.com/jakeogh/ldirparser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/csvparser[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
