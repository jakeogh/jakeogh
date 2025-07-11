# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3

#inherit xdg

DESCRIPTION="Paper backup of files using QR codes"
HOMEPAGE="https://github.com/jakeogh/qr-backup"
EGIT_REPO_URI="/home/sysskel/myapps/qr-backup https://github.com/jakeogh/qr-backup.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

src_install() {
	dobin ${PN}
}
