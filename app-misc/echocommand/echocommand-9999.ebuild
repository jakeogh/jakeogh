# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION=""
HOMEPAGE="https://github.com/jakeogh/dodo command prior to execution."
EGIT_REPO_URI="/home/cfg/_myapps/echocommand https://github.com/jakeogh/echocommand.git"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""

src_install() {
	dobin ${PN}
}
