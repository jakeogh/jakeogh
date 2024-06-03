# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 git-r3

DESCRIPTION="Calculate RAID size given a geometry"
HOMEPAGE="https://github.com/jakeogh/raidcalc"
EGIT_REPO_URI="https://github.com/jakeogh/raidcalc.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/cytoolz[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
