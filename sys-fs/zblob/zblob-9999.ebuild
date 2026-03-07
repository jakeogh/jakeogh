# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..13} )
inherit linux-mod-r1 python-single-r1

DESCRIPTION="Content-addressable blob store backed by ZFS DMU objects"
HOMEPAGE="https://github.com/FIXME/zblob"

LICENSE="CDDL GPL-2"
SLOT="0"
KEYWORDS=""

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="file:///home/sysskel/myapps/zblob"
fi

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	sys-fs/zfs
	${PYTHON_DEPS}
"
RDEPEND="
	sys-fs/zfs
	${PYTHON_DEPS}
"

CONFIG_CHECK="CRYPTO"

pkg_setup() {
	linux-mod-r1_pkg_setup
	python-single-r1_pkg_setup
}

src_compile() {
	local modlist=(
		zblob_crypto=extra:${S}
		zblob=extra:${S}
	)
	local modargs=( KVER="${KV_FULL}" )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

	python_domodule zblob.py

	insinto /usr/include
	doins zblob.h

	insinto /lib/udev/rules.d
	newins - 90-zblob.rules <<-EOF
		KERNEL=="zblob", MODE="0660", GROUP="wheel"
	EOF
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
	elog "Load now: modprobe zblob_crypto && modprobe zblob"
	elog "Device:   /dev/zblob (group wheel)"
	elog "Python:   import zblob"
}
