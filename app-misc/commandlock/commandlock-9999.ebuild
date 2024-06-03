# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Prevent identical bash/sh commands from executing concurrently."
HOMEPAGE="https://github.com/jakeogh/commandlock"
EGIT_REPO_URI="https://github.com/jakeogh/commandlock.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""


src_install() {
	dobin ${PN}
	dobin ${PN}-test
	dobin lock
}
