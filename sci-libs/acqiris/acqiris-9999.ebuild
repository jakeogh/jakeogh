# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info git-r3 eutils linux-mod toolchain-funcs

DESCRIPTION="Acqiris device interface (kernel modules)"
HOMEPAGE="https://www.keysight.com/en/pd-1184928-pn-U1068A/acqiris-8-bit-high-speed-pci-digitizers"
EGIT_REPO_URI="/home/user/_myapps/acqiris"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
#CONFIG_CHECK="COMEDI"
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
	#eautoreconf
	default
}

#src_configure() {
#	econf --prefix=/
#}

src_compile() {
	emake CFLAGS="${CFLAGS} -std=gnu99"
}


src_install() {
	#unset ARCH
	emake DESTDIR="${D}" install
}

