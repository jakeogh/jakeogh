# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/ueberzug"
EGIT_REPO_URI="/home/sysskel/myapps/ueberzug https://github.com/jakeogh/ueberzug.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/python-xlib[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
