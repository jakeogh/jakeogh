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
#BUILD_TARGETS="all"
CONFIG_CHECK="COMEDI"
MODULE_NAMES="pcl730(misc)"

pkg_setup() {
	linux-info_pkg_setup || die
	linux-mod_pkg_setup || die
	set_arch_to_kernel || die
	require_configured_kernel || die
	linux_chkconfig_present "COMEDI" || die
	check_kernel_built || die
	#BUILD_TARGETS="all"
	#unset INSTALL_MOD_PATH
	#ARCH="$(tc-arch-kernel)"
	#ABI="${KERNEL_ABI}"
}

src_prepare() {
	#unset INSTALL_MOD_PATH
	eautoreconf
	default
	sed -i '
			/INSTALL_MOD_PATH=/c\      INSTALL_MOD_PATH="/lib" modules_install
' comedi/Makefile.am || die
}

src_configure() {
	#unset INSTALL_MOD_PATH
	#unset ARCH
	#ECONF_SOURCE="${S}" econf || die
	econf
}

src_compile() {
	#unset INSTALL_MOD_PATH
	#unset ARCH
	default
	linux-mod_src_compile || die
}

src_install() {
	#unset INSTALL_MOD_PATH  # get sandbox violation: " * ACCESS DENIED:  mkdir:        /usr/lib64/modules" with or without this
	unset ARCH
	#emake install INSTALL_MOD_PATH="/lib" || die
	linux-mod_src_install INSTALL_MOD_PATH="/lib" || die
}

