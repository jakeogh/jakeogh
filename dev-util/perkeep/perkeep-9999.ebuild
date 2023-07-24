# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit go-module

#inherit xdg

DESCRIPTION="personal storage system for life"
HOMEPAGE="https://github.com/jakeogh/perkeep"
EGIT_REPO_URI="/home/sysskel/myapps/perkeep https://github.com/jakeogh/perkeep.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

src_unpack() {
        if [[ ${PV} == *9999 ]]; then
                git-r3_src_unpack
                go-module_live_vendor
        else
                go-module_src_unpack
        fi
}

src_compile() {
	#export GOFLAGS="-offline"
	#export GO_BUILD_FLAGS="-offline"
	#go run make.go -offline
	rm Makefile || die
	go run make.go -offline PREFIX="${EPREFIX}/usr"
	#emake -offline PREFIX="${EPREFIX}/usr"
}

src_install() {
	GOBIN=${S}/bin CGO_ENABLED=0 go install ./... || die
}

#src_prepare() {
#	default
#	xdg_src_prepare
#}
