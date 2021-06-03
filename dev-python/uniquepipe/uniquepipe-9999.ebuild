# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3

DESCRIPTION="Pipe filter to pass unique items by hash tracking"
HOMEPAGE="https://github.com/jakeogh/uniquepipe"
EGIT_REPO_URI="/home/cfg/_myapps/uniquepipe https://github.com/jakeogh/uniquepipe.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/bitstring[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
