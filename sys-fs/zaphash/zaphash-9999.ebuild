# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
inherit linux-mod-r1 python-single-r1

DESCRIPTION="Content-addressable hash store backed by ZFS ZAP objects"
HOMEPAGE="https://github.com/FIXME/zaphash"

LICENSE="CDDL GPL-2"
SLOT="0"
KEYWORDS=""

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="file:///home/sysskel/myapps/zaphash"
fi

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	sys-fs/zfs-kmod
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
		zaphash_crypto=extra:${S}
		zaphash=extra:${S}
	)
	local modargs=( KVER="${KV_FULL}" )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

	python_domodule zaphash.py

	insinto /usr/include
	doins zaphash.h

	insinto /lib/udev/rules.d
	newins - 90-zaphash.rules <<-EOF
		KERNEL=="zaphash", MODE="0660", GROUP="wheel"
	EOF

	#insinto /etc/modules-load.d
	#newins - zaphash.conf <<-EOF
	#	zaphash_crypto
	#	zaphash
	#EOF
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
	elog "Load now: modprobe zaphash_crypto && modprobe zaphash"
	elog "Device:   /dev/zaphash (group wheel)"
	elog "Python:   import zaphash"
}
