# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
inherit linux-mod-r1 python-single-r1

DESCRIPTION="Bidirectional relationship map backed by ZFS ZAP objects"
HOMEPAGE="https://github.com/FIXME/relmap"

LICENSE="CDDL"
SLOT="0"
KEYWORDS=""

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="file:///home/sysskel/myapps/relmap"
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

pkg_setup() {
	linux-mod-r1_pkg_setup
	python-single-r1_pkg_setup
}

src_compile() {
	local modlist=(
		relmap=extra:${S}
	)
	local modargs=( KVER="${KV_FULL}" )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

	python_domodule relmap.py

	insinto /usr/include
	doins relmap.h

	insinto /lib/udev/rules.d
	newins - 90-relmap.rules <<-EOF
		KERNEL=="relmap", MODE="0660", GROUP="wheel"
	EOF

	#insinto /etc/modules-load.d
	#newins - relmap.conf <<-EOF
	#	relmap
	#EOF
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
	elog "Load now: modprobe relmap"
	elog "Device:   /dev/relmap (group wheel)"
	elog "Python:   import relmap"
}
