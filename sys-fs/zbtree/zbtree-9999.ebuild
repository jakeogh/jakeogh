# Copyright 2026 Gentoo Authors
# Distributed under the terms of the CDDL-1.0 license
# SPDX-License-Identifier: CDDL-1.0

EAPI=8
PYTHON_COMPAT=( python3_{12..13} )

inherit git-r3 linux-mod-r1 python-single-r1

DESCRIPTION="Sorted edge store backed by B+ tree on ZFS DMU objects"
HOMEPAGE="https://github.com/FIXME/zbtree"
EGIT_REPO_URI="/home/sysskel/myapps/zbtree"

LICENSE="CDDL"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	dev-libs/bptree
	sys-fs/zfs
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
"

pkg_setup() {
	python-single-r1_pkg_setup
	linux-mod-r1_pkg_setup
}

src_compile() {
	local modlist=( zbtree=extra )
	local modargs=(
		KDIR="${KV_OUT_DIR}"
		BPTREE_SRC="${EPREFIX}/usr/src/bptree"
	)
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	insinto /usr/include/zbtree
	doins zbtree.h
	python_domodule zbtree.py
}
