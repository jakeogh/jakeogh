# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="OpenRC local.d script to safely generate cpu_flags.conf from cpuid2cpuflags"
HOMEPAGE="https://github.com/jakeogh/portage-set-cpu-flags-on-boot"
EGIT_REPO_URI="https://github.com/jakeogh/portage-set-cpu-flags-on-boot.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

# cpuid2cpuflags provides the detection utility
RDEPEND="app-portage/cpuid2cpuflags"

# No build phase, pure script installation
src_install() {
    local commit=$(git rev-parse --short HEAD)
    sed "s/^# Version: .*/# Version:    git-${commit}/" \
        portage_set_cpu_flags.start > "${T}/portage_set_cpu_flags.start"

    exeinto /etc/local.d
    doexe "${T}/portage_set_cpu_flags.start"
}
