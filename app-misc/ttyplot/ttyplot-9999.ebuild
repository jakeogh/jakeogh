# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs git-r3

DESCRIPTION="a realtime plotting utility for terminal with data input from stdin"
HOMEPAGE="https://github.com/tenox7/ttyplot"
EGIT_REPO_URI="https://github.com/tenox7/ttyplot.git"

LICENSE="Apache-2.0"
SLOT="0"

KEYWORDS=""
IUSE=""
RDEPEND=""
DEPEND=""

src_prepare() {
	default
}

src_compile() {
	tc-export CC
	emake
}

src_install() {
	dobin ttyplot
}
