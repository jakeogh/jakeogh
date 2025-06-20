# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="OpenRC local.d scripts to safely generate cpu_flags.conf and cflags.conf"
HOMEPAGE="https://github.com/jakeogh/portage-set-compile-flags-on-boot"
EGIT_REPO_URI="https://github.com/jakeogh/portage-set-compile-flags-on-boot.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-portage/cpuid2cpuflags"
BDEPEND="virtual/pkgconfig"

src_prepare() {
    default
    emake -f Makefile cpu_flags || die "make cpu_flags failed"
}

src_install() {
    exeinto /etc/local.d
	doexe "portage_set_cpu_flags.start" || die "failed to install .start script"
}

