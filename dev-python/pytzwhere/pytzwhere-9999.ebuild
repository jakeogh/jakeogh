# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/pytzwhere"
EGIT_REPO_URI="/home/cfg/_myapps/pytzwhere https://github.com/jakeogh/pytzwhere.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-libs/shapely[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"


#src_prepare() {
#	default
#	xdg_src_prepare
#}
