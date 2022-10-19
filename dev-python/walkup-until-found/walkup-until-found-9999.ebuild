# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 git-r3

DESCRIPTION="locate name somewhere above the current folder location"
HOMEPAGE="https://github.com/jakeogh/walkup_until_found"
EGIT_REPO_URI="/home/cfg/_myapps/walkup_until_found https://github.com/jakeogh/walkup_until_found.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/mptool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
