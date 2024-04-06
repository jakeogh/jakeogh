# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3

DESCRIPTION="automatically fixes wrong import statements"
HOMEPAGE="https://github.com/jakeogh/autoimport"
EGIT_REPO_URI="/home/sysskel/myapps/autoimport https://github.com/jakeogh/autoimport.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}
