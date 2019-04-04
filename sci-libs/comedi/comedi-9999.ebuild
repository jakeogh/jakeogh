# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info git-r3 autotools eutils linux-mod toolchain-funcs

DESCRIPTION="Linux control and measurement device interface (kernel modules)"
HOMEPAGE="http://www.comedi.org/"
EGIT_REPO_URI="https://github.com/Linux-Comedi/comedi.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""

CONFIG_CHECK="COMEDI"

pkg_setup() {
	linux-mod_pkg_setup
}

src_configure() {
	unset ARCH
	default
}

src_prepare() {
	unset ARCH
	eapply_user
	eautoreconf
}

src_configure() {
	unset ARCH
	ECONF_SOURCE="${S}" econf
}

src_install() {
	unset ARCH
	linux-mod_src_install || die
}

