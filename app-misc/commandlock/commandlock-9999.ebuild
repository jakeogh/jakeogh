# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#inherit distutils-r1
inherit git-r3

DESCRIPTION="Prevent identical bash/sh command lines from executing concurrently."
HOMEPAGE="https://github.com/jakeogh/commandlock"
EGIT_REPO_URI="https://github.com/jakeogh/commandlock.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="+minimal test"

#RDEPEND="!minimal? ( ${COMMON_DEPS} )"
DEPEND=""

#src_compile() { :; }

src_install() {
#	dodoc README*
	dobin ${PN}
	dobin ${PN}_test
	dobin lock
#	dobin commandlock
}
