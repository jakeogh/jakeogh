# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Linux resource monitor"
HOMEPAGE="https://github.com/aristocratos/bashtop"
EGIT_REPO_URI="https://github.com/aristocratos/bashtop.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND=""

DEPEND="${RDEPEND}"

src_install() {
	dobin ${PN}
}
