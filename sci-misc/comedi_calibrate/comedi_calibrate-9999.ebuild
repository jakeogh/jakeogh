# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# from https://raw.githubusercontent.com/Jannis234/jm-overlay/master/sci-misc/comedi_calibrate/comedi_calibrate-3-r2.ebuild

EAPI=7

inherit eutils git-r3

DESCRIPTION="Linux control and measurement device interface (calibration tool)"
HOMEPAGE="http://www.comedi.org/"
#SRC_URI="http://www.comedi.org/download/${P}.tar.gz"
EGIT_REPO_URI="https://github.com/Linux-Comedi/comedi_calibrate.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="sci-libs/comedilib
	sci-libs/gsl
	dev-libs/boost"
DEPEND="${RDEPEND}"

src_prepare() {
	eapply_user
	eautoreconf
}

src_configure() {
	ECONF_SOURCE="${S}" econf
	#default
}

src_compile() {
	default
}

src_install() {
	default
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
