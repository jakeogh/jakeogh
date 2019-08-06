# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#inherit distutils-r1
inherit git-r3

DESCRIPTION="vi wrapper for workflow"
HOMEPAGE="https://github.com/jakeogh"
EGIT_REPO_URI="/home/cfg/_myapps/edit"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#RDEPEND="!minimal? ( ${COMMON_DEPS} )"
DEPEND="dev-util/splint
app-portage/repoman
dev-util/shellcheck
dev-python/pylint
app-misc/commandlock
app-editors/neovim
"

#src_compile() { :; }

src_install() {
#	dodoc README*
	dobin ${PN}
#	dobin ${PN}_test
#	dobin lock
#	dobin commandlock
}
