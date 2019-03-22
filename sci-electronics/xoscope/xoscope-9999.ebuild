# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils linux-info git-r3

DESCRIPTION="Soundcard Oscilloscope for X"
HOMEPAGE="http://xoscope.sourceforge.net"
#SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${PV}/${P}.tar.gz"
EGIT_REPO_URI="https://git.code.sf.net/p/xoscope/code"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtkdatabox
	virtual/man"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

CONFIG_CHECK="~!SND_PCM_OSS"
ERROR_SND_PCM_OSS="CONFIG_SND_PCM_OSS is needed to support sound card input via /dev/dsp"

src_prepare() {
	epatch "${FILESDIR}"/${P}-man_no_-Tutf8.patch

	eautoreconf
}
