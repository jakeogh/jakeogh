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

RDEPEND="app-portage/cpuid2cpuflags"

src_prepare() {
    default

    local commit=$(git rev-parse --short HEAD)
    local out="${T}/portage_set_cpu_flags.start"

    local replacements=(
        -e "s|{PROGRAM_NAME}|portage-set-cpu-flags-on-boot|g"
        -e "s|{PROGRAM_NAME_UNDERSCORE}|portage_set_cpu_flags|g"
        -e "s|{FLAG_COMMAND}|cpuid2cpuflags|g"
        -e "s|{CONFIG_FILE}|cpu_flags.conf|g"
        -e "s|{CONF_FILE}|cpu_flags.conf|g"
        -e "s|{FLAG_PACKAGE}|cpuid2cpuflags|g"
        -e "s|{REPO_URL}|https://github.com/jakeogh/portage-set-cpu-flags-on-boot|g"
        -e "s|{AUTHOR}|Justin Keogh <jakeogh@users.noreply.github.com>|g"
        -e "s|{LICENSE}|MIT|g"
        -e "s|{VERSION}|git-${commit}|g"
        -e "s|{TYPE_OF_FLAGS}|CPU|g"
        -e "s|{FILES_DIR_URL}|https://github.com/jakeogh/jakeogh/fixme|g"
    )

    # Apply header template
    sed "${replacements[@]}" "${FILESDIR}/set_flags_template.in" > "${out}" || die

    # Append body template
    sed "${replacements[@]}" "${FILESDIR}/start_template.in" >> "${out}" || die

    chmod +x "${out}" || die
}

src_install() {
    exeinto /etc/local.d
    doexe "${T}/portage_set_cpu_flags.start"
}

