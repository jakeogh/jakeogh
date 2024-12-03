# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="locate name somewhere above the current folder location"
HOMEPAGE="https://github.com/jakeogh/walkup-until-found"
EGIT_REPO_URI="https://github.com/jakeogh/walkup-until-found.git"
#EGIT_REPO_URI="/home/sysskel/myapps/walkup-until-found"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/mptool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
