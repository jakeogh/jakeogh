# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Force color output for terminal commands."
HOMEPAGE="https://github.com/jakeogh/colorpipe"
EGIT_REPO_URI="https://github.com/jakeogh/colorpipe.git"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS=""

DEPEND="dev-lang/tcl"

src_install() {
	dobin ${PN}
}
