# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info multilib-minimal git-r3 autotools eutils linux-mod

DESCRIPTION="Linux control and measurement device interface (kernel modules)"
HOMEPAGE="http://www.comedi.org/"
EGIT_REPO_URI="https://github.com/Linux-Comedi/comedi.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""

CONFIG_CHECK="COMEDI"


src_configure() {
	unset ARCH
	default
}

src_prepare() {
	eapply_user
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf
}

multilib_src_install() {
	linux-mod_src_install
}

multilib_src_install_all() {
	default
#	cd "${S}"
#	dodoc INSTALL AUTHORS ChangeLog NEWS README
}
