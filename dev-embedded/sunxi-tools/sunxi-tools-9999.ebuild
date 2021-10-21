# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3

#inherit xdg

DESCRIPTION="Tools for Allwinner A10 devices."
HOMEPAGE="https://github.com/jakeogh/sunxi-tools"
EGIT_REPO_URI="/home/cfg/_myapps/sunxi-tools https://github.com/jakeogh/sunxi-tools.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}
