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
	emake -f Makefile cpu_flags OUT="${S}/portage_set_cpu_flags.start" || die "make cpu_flags failed"
	/bin/ls -alht
	pwd
}

src_install() {
	exeinto /etc/local.d

	local script="${S}/portage_set_cpu_flags.start"
	[[ -e "${script}" ]] || die "Expected output file not found: ${script}"

	einfo "DEBUG: S=${S}"
	einfo "DEBUG: script=${script}"
	einfo "DEBUG: listing content of $(dirname "${script}")"
	ls -l "${script}" || einfo "DEBUG: script not found at install time"
	doexe "${script}" || die "failed to install .start script"
}
