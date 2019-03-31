# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#inherit distutils-r1
inherit git-r3

DESCRIPTION="make new python app from template"
HOMEPAGE="https://github.com/jakeogh/newapp"
EGIT_REPO_URI="https://github.com/jakeogh/newapp.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

#RDEPEND="!minimal? ( ${COMMON_DEPS} )"
#DEPEND="sys-apps/coreutils
#dev-util/splint
#dev-util/shellcheck
#dev-python/pylint
#app-misc/commandlock
#app-editors/neovim
#"

#src_compile() { :; }

src_install() {
#	dodoc README*
	dobin ${PN}
#	dobin ${PN}_test
#	dobin lock
#	dobin commandlock
}
