# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Report system wide file access events"
HOMEPAGE="https://github.com/martinpitt/fatrace"
EGIT_REPO_URI="https://github.com/martinpitt/fatrace.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die "Install failed."
}
