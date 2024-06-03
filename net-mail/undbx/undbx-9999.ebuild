# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools
inherit git-r3
inherit toolchain-funcs

DESCRIPTION="https://github.com/ZungBang/undbx"
HOMEPAGE="https://github.com/ZungBang/undbx"
EGIT_REPO_URI="https://github.com/ZungBang/undbx.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


src_prepare() {
        default
}

src_compile() {
        emake
}


