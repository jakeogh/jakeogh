# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="colorized data storage scheme for printing on paper"
HOMEPAGE="https://github.com/jakeogh/colorsafe"
EGIT_REPO_URI="https://github.com/jakeogh/colorsafe.git"
EGIT_BRANCH='py3'

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/reedsolomon[${PYTHON_USEDEP}]
	dev-python/reportlab[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
