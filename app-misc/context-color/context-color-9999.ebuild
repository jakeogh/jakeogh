# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="convert any content into a deterministic shell color"
HOMEPAGE="https://github.com/ramnes/context-color"
EGIT_REPO_URI="/home/sysskel/myapps/context-color https://github.com/ramnes/context-color.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

src_install() {
    dobin ${PN}
}
