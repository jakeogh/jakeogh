# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/timezonefinder"
EGIT_REPO_URI="/home/sysskel/myapps/timezonefinder https://github.com/jakeogh/timezonefinder.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


#	dev-python/numba[${PYTHON_USEDEP}]
RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

