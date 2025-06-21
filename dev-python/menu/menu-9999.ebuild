# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

DESCRIPTION="Wrapper for dmenu and slmenu for X or VT"
HOMEPAGE="https://github.com/jakeogh/menu"
EGIT_REPO_URI="https://github.com/jakeogh/menu.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/colorama[${PYTHON_USEDEP}]
	app-misc/slmenu
	x11-misc/dmenu
"

DEPEND="${RDEPEND}"
