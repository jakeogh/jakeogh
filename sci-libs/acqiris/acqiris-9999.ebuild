# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info git-r3 eutils linux-mod toolchain-funcs

DESCRIPTION="Acqiris device interface (kernel modules)"
HOMEPAGE="https://www.keysight.com/en/pd-1184928-pn-U1068A/acqiris-8-bit-high-speed-pci-digitizers"
EGIT_REPO_URI="/home/cfg/_myapps/acqiris_kernel26module"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
BUILD_TARGETS="all"
#MODULE_NAMES="acqiris(misc)"

pkg_setup() {
	linux-info_pkg_setup
	linux-mod_pkg_setup
	set_arch_to_kernel
	require_configured_kernel || die
	check_kernel_built || die
}

src_prepare() {
	default
	sed -i '
	/KERNELBUILD=/c\KERNELBUILD=$(DESTDIR)/lib/modules/$(KERNELVERSION)/build
' Makefile || die
}

src_compile() {
	emake DESTDIR="${D}" CFLAGS="${CFLAGS} -std=gnu99"
}

src_install() {
	emake DESTDIR="${D}" install
}

