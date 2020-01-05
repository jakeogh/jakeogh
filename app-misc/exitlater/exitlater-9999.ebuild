# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Run command at interval until command exits 0."
HOMEPAGE="https://github.com/jakeogh/exitlater"
EGIT_REPO_URI="https://github.com/jakeogh/exitlater.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND=""

src_install() {
	dobin ${PN}
}
