# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 git-r3

DESCRIPTION="Python object abstraction over redis keys"
HOMEPAGE="https://github.com/jakeogh/rediskey"
EGIT_REPO_URI="/home/cfg/_myapps/rediskey https://github.com/jakeogh/rediskey.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/pycolumnize[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

