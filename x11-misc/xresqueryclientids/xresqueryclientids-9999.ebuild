# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3

# from: https://stackoverflow.com/questions/37283179/python-pid-to-x11-window-id-using-xresqueryclientids
DESCRIPTION="XResQueryClientIds example"
HOMEPAGE="https://github.com/jakeogh/xresqueryclientids"
EGIT_REPO_URI="https://github.com/jakeogh/xresqueryclientids.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
	#einstalldocs
}

