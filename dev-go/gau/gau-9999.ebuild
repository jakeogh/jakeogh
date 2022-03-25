# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3

inherit go-module golang-vcs golang-vcs-snapshot golang-build

DESCRIPTION="list all pages archived in the wayback machine"
HOMEPAGE="https://github.com/jakeogh/gau"
EGIT_REPO_URI="/home/cfg/_myapps/gau https://github.com/jakeogh/gau.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

src_prepare() {
	default
	#xdg_src_prepare
}

src_compile() {
	go build -mod=vendor . || die
}

src_install() {
	dobin ${PN}
}
