# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/ccryptotool"
EGIT_REPO_URI="/home/cfg/_myapps/cryptotool https://github.com/jakeogh/cryptotool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/blocktool[${PYTHON_USEDEP}]
	dev-python/mounttool[${PYTHON_USEDEP}]
	dev-python/kcl[${PYTHON_USEDEP}]
	dev-python/run-command[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"


