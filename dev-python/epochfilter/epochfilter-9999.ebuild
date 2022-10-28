# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/epochfilter"
EGIT_REPO_URI="/home/cfg/_myapps/epochfilter https://github.com/jakeogh/epochfilter.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/unitcalc[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

