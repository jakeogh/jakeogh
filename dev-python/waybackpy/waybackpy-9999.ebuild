# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="Wayback Machine API interface & a command-line tool"
HOMEPAGE="https://github.com/jakeogh/waybackpy"
EGIT_REPO_URI="/home/sysskel/myapps/waybackpy https://github.com/jakeogh/waybackpy.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
"

DEPEND="${RDEPEND}"


src_prepare() {
	default
	xdg_src_prepare
	rm -rf tests || die
}
