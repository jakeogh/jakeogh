# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Make a unique string based on the current hardware."
HOMEPAGE="https://github.com/jakeogh/machinesignaturetool"
EGIT_REPO_URI="https://github.com/jakeogh/machinesignaturetool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

src_install() {
	dobin ${PN}
}
