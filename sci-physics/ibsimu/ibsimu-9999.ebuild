# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit toolchain-funcs
inherit autotools

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/ibsimu"
EGIT_REPO_URI="/home/cfg/_myapps/ibsimu https://github.com/jakeogh/ibsimu.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf
}

src_install() {
	default
}
