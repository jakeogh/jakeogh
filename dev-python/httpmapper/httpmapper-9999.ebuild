# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3

#inherit xdg

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/httpmapper"
EGIT_REPO_URI="/home/sysskel/myapps/httpmapper https://github.com/jakeogh/httpmapper.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}
