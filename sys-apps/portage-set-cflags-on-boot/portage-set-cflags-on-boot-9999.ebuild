# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3

DESCRIPTION="local.d script to generate cflags include file for make.conf"
HOMEPAGE="https://github.com/jakeogh/portage-set-cflags-on-boot"
EGIT_REPO_URI="/home/sysskel/myapps/portage-set-cflags-on-boot https://github.com/jakeogh/portage-cflags-on-boot.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

src_install() {
	exeinto /etc/local.d
	doexe portage_set_cflags.start
}