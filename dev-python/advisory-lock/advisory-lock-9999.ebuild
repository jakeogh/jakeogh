# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Contexy manager for fcntl"
HOMEPAGE="https://github.com/jakeogh/advisory-lock"
EGIT_REPO_URI="/home/cfg/_myapps/advisory-lock https://github.com/jakeogh/advisory-lock.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/mptool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

