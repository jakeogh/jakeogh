# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Played quered media from redis"
HOMEPAGE="https://github.com/jakeogh/mpvauto"
EGIT_REPO_URI="/home/cfg/_myapps/mpvauto https://github.com/jakeogh/mpvauto.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/stringfilter[${PYTHON_USEDEP}]
	dev-python/mpvpy[${PYTHON_USEDEP}]
	dev-python/redisfilter[${PYTHON_USEDEP}]
"
