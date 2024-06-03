# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/chriswolfvision/eplot"
EGIT_REPO_URI="https://github.com/chriswolfvision/eplot.git"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-lang/ruby:*
	>=sci-visualization/gnuplot-4.0
"

DEPEND="${RDEPEND}"

src_install() {
	dobin ${PN}
	dobin ec
}
