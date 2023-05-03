# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/timezonefinder"
EGIT_REPO_URI="/home/cfg/_myapps/timezonefinder https://github.com/jakeogh/timezonefinder.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


#	dev-python/numba[${PYTHON_USEDEP}]
RDEPEND="
"

DEPEND="${RDEPEND}"


#src_prepare() {
#	default
#	xdg_src_prepare
#}
