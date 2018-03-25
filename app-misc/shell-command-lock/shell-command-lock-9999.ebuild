# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#inherit distutils-r1
inherit git-r3

DESCRIPTION="Prevent identical bash/sh command lines from executing concurrently."
HOMEPAGE="https://github.com/jakeogh/shell-command-lock"
EGIT_REPO_URI="https://github.com/jakeogh/shell-command-lock.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="+minimal test"

#RDEPEND="!minimal? ( ${COMMON_DEPS} )"
DEPEND="sys-apps/coreutils"

#src_compile() { :; }

src_install() {
#	dodoc README*
	dobin ${PN}
	dobin ${PN}-test
#	dobin shell-command-lock
}
