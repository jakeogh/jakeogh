# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

EGO_PN="github.com/lc/gau/v2/cmd/gau"

DESCRIPTION="Fetch known URLs from the Wayback Machine and other sources"
HOMEPAGE="https://github.com/lc/gau"
EGIT_REPO_URI="https://github.com/lc/gau.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND=">=dev-lang/go-1.20"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	go-module_setup_proxy
}

src_compile() {
	ego build -o ${PN} || die "Failed to build gau"
}

src_install() {
	dobin ${PN}
	dodoc README.md
}
