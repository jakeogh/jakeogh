# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit git-r3

DESCRIPTION="Outputs X window title given windowid"
HOMEPAGE="https://github.com/jakeogh/bspwm-xtitle"
EGIT_REPO_URI="/home/cfg/_myapps/bspwm-xtitle https://github.com/jakeogh/bspwm-xtitle.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
	einstalldocs
}