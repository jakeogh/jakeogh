# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Group specific types from the 'file' comand"
HOMEPAGE="https://github.com/jakeogh/classify"
EGIT_REPO_URI="/home/cfg/_myapps/classify https://github.com/jakeogh/classify.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	media-gfx/gifsicle
"

DEPEND="${RDEPEND}"
