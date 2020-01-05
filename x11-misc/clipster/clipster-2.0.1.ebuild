# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# from https://github.com/fkmclane/overlay
DESCRIPTION="simple clipboard manager"
HOMEPAGE="https://github.com/mrichar1/clipster"
SRC_URI="https://github.com/mrichar1/clipster/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-lang/python:*
"

src_install() {
	dobin clipster
}
