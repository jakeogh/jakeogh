# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info git-r3 autotools linux-mod toolchain-funcs

DESCRIPTION="Linux control and measurement device interface (kernel modules)"
HOMEPAGE="http://www.comedi.org/"
EGIT_REPO_URI="https://github.com/Linux-Comedi/comedi.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
CONFIG_CHECK="COMEDI"
#MODULE_NAMES="pcl730(misc)"

pkg_setup() {
	linux-info_pkg_setup || die
	linux-mod_pkg_setup || die
	set_arch_to_kernel || die
	require_configured_kernel || die
	linux_chkconfig_present "COMEDI" || die
	check_kernel_built || die
}

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf --prefix=/
}

src_compile() {
	default
}

src_install() {
	unset ARCH
	emake DESTDIR="${D}" install
}

