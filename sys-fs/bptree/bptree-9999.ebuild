# Copyright 2026 Gentoo Authors
# Distributed under the terms of the CDDL-1.0 license
# SPDX-License-Identifier: CDDL-1.0

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Portable B+ tree library with pluggable block I/O"
HOMEPAGE="https://github.com/FIXME/bptree"
EGIT_REPO_URI="/home/sysskel/myapps/bptree"

LICENSE="CDDL"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

src_compile() {
	emake CC="$(tc-getCC)" AR="$(tc-getAR)" \
		CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		libbptree.a
}

src_test() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		bptree_test
	./bptree_test || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" \
		LIBDIR="${EPREFIX}/usr/$(get_libdir)" \
		install

	dodoc README.md
}
