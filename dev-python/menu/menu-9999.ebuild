# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Wrapper for dmenu and slmenu for X or VT"
HOMEPAGE="https://github.com/jakeogh/menu"
EGIT_REPO_URI="/home/cfg/_myapps/menu https://github.com/jakeogh/menu.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	app-misc/slmenu
	x11-misc/dmenu
"

DEPEND="${RDEPEND}"
