# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="like cat, but accepts paths on stdin"
HOMEPAGE="https://github.com/jakeogh/pycat"
EGIT_REPO_URI="/home/cfg/_myapps/pycat https://github.com/jakeogh/pycat.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
