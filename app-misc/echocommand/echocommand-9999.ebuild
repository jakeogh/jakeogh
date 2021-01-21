# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION=""
HOMEPAGE="https://github.com/jakeogh/dodo command prior to execution."
EGIT_REPO_URI="/home/user/_myapps/echocommand https://github.com/jakeogh/echocommand.git"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""


src_install() {
#	dodoc README*
	dobin ${PN}
#	dobin ${PN}_test
}
