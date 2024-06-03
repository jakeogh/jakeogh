# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Repeat command execution at interval."
HOMEPAGE="https://github.com/jakeogh/dodo"
EGIT_REPO_URI="https://github.com/jakeogh/dodo.git"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""


src_install() {
	dobin ${PN}
	dosym "/usr/bin/${PN}" "/usr/bin/${PN}-force"
}
