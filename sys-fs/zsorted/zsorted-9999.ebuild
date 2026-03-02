# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..13} )
inherit linux-mod-r1 python-single-r1

DESCRIPTION="Sorted fixed-size record store backed by B+ tree on ZFS DMU"
HOMEPAGE="https://github.com/FIXME/zsorted"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="file:///home/sysskel/myapps/zsorted"
fi

LICENSE="CDDL"
SLOT="0"
KEYWORDS=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	sys-fs/zfs
	dev-libs/bptree
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
	sys-fs/zfs
"
BDEPEND="
	${PYTHON_DEPS}
	virtual/linux-sources
"

src_compile() {
	local modlist=( zsorted=extra )
	local modargs=(
		KVER="${KV_FULL}"
		KDIR="${KERNEL_DIR}"
		BPTREE_SRC="/usr/src/bptree"
	)
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

	python_domodule zsorted.py

	insinto /usr/include/zsorted
	doins zsorted.h

	einstalldocs
}
