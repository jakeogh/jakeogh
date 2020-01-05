# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit git-r3

DESCRIPTION="Colourful visualization tool for binary files"
HOMEPAGE="https://github.com/FireyFly/pixd"
EGIT_REPO_URI="https://github.com/FireyFly/pixd.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dobin "${PN}"
}
