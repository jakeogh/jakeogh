# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
inherit toolchain-funcs

DESCRIPTION="Tools for Allwinner A10 devices."
HOMEPAGE="https://github.com/jakeogh/sunxi-tools"
EGIT_REPO_URI="/home/cfg/_myapps/sunxi-tools https://github.com/jakeogh/sunxi-tools.git"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS=""

DEPEND="virtual/libusb"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -std=c99 -D_POSIX_C_SOURCE=200112L -Iinclude/" tools misc
}

src_install() {
	dobin bin2fex
	dobin fex2bin
	dobin phoenix_info
	dobin sunxi-bootinfo
	dobin sunxi-fel
	dobin sunxi-fexc
	dobin sunxi-nand-part
	dobin sunxi-pio
}
