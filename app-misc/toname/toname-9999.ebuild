# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Redirect stdin to temporary named pipe."
HOMEPAGE="https://github.com/jakeogh/toname"
EGIT_REPO_URI="https://github.com/jakeogh/toname.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND=""

src_install() {
	dobin ${PN}
}
