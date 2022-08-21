# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="assertish funcs"
HOMEPAGE="https://github.com/jakeogh/asserttool"
EGIT_REPO_URI="/home/cfg/_myapps/asserttool https://github.com/jakeogh/asserttool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/eprint[${PYTHON_USEDEP}]
	dev-python/epprint[${PYTHON_USEDEP}]
	dev-python/ipdb[${PYTHON_USEDEP}]
"
	#dev-python/ipdb[${PYTHON_USEDEP}]  #loootta deps

DEPEND="${RDEPEND}"
