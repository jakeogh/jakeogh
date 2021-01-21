# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Repeat command execution at interval."
HOMEPAGE="https://github.com/jakeogh/dodo"
EGIT_REPO_URI="/home/user/_myapps/dodo https://github.com/jakeogh/dodo.git"

LICENSE="UNLICENSE"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""


src_install() {
#	dodoc README*
	dobin ${PN}
#	dobin ${PN}_test
#	dobin dodo
#	dobin commandlock
}
