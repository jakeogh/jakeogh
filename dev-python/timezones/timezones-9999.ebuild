# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/timezones"
EGIT_REPO_URI="/home/cfg/_myapps/timezones https://github.com/jakeogh/timezones.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/pytzwhere[${PYTHON_USEDEP}]
	dev-python/timezonefinder[${PYTHON_USEDEP}]
"
	#dev-python/click-command-tree[${PYTHON_USEDEP}]

DEPEND="${RDEPEND}"


#src_prepare() {
#	default
#	xdg_src_prepare
#}