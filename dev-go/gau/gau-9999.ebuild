# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3

inherit go-module golang-vcs golang-build

EGO_PN=github.com/lc/gau/v2/cmd/gau@latest

DESCRIPTION="list all pages archived in the wayback machine"
HOMEPAGE="https://github.com/lc/gau"
EGIT_REPO_URI="https://github.com/lc/gau"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

#src_prepare() {
#	default
#	#xdg_src_prepare
#}

src_compile() {
	go build -mod=vendor . || die
}

src_install() {
	dobin ${PN}
}
