# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Decorator to retry a function call on an exception"
HOMEPAGE="https://github.com/jakeogh/enumerate-input"
EGIT_REPO_URI="/home/cfg/_myapps/enumerate-input https://github.com/jakeogh/enumerate-input.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/delay-timer[${PYTHON_USEDEP}]
	dev-python/bytestool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
