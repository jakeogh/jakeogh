# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="local.d script to generate CPU_FLAGS_x include file for make.conf"
HOMEPAGE="https://github.com/jakeogh/portage-set-cpu-flags-on-boot"
EGIT_REPO_URI="/home/sysskel/myapps/portage-set-cpu-flags-on-boot https://github.com/jakeogh/portage-set-cpu-flags-on-boot.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

src_install() {
	doinitd portage_set_cpu_flags.start
}