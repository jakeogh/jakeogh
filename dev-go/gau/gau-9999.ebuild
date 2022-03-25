# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3

#inherit go-module golang-vcs golang-build
inherit golang-vcs golang-build

#EGO_PN=github.com/lc/gau/v2/cmd/gau@latest
EGO_PN=github.com/lc/gau

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

src_unpack() {
	git-r3_src_unpack
	#go-module_live_vendor
}


#src_compile() {
#	#go build -mod=vendor . || die
#	go build . || die
#}

src_install() {
	dobin ${PN}
}
