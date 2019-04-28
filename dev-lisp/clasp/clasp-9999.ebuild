# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='threads(+)'

inherit eutils multilib git-r3 waf-utils python-single-r1 llvm cmake-utils

DESCRIPTION="clasp Common Lisp environment"
HOMEPAGE="https://github.com/clasp-developers/clasp"
EGIT_REPO_URI="https://github.com/clasp-developers/clasp"

LICENSE="LGPL-2.1+"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="threads"

CDEPEND="dev-libs/gmp:0
		virtual/libffi
		sys-devel/gcc:*
		dev-libs/boehm-gc[threads?]
		sys-devel/binutils:*
		sys-libs/zlib
		sys-libs/ncurses:*
		dev-libs/boost
		sys-libs/libunwind
		dev-libs/libbsd
		dev-lisp/sbcl
		=sys-devel/llvm-6.0.1-r2:=
		~sys-devel/clang-6.0.1:="

DEPEND="${CDEPEND}"

RDEPEND="${CDEPEND}"

LLVM_MAX_SLOT=6

llvm_check_deps() {
	has_version "sys-devel/clang:${LLVM_SLOT}"
}

pkg_setup () {
	local -x CC=${CHOST}-clang
	local -x CXX=${CHOST}-clang++
	#CC=${EPREFIX}/usr/lib/llvm/${CLANG_SLOT}/bin/clang
	#CXX=${EPREFIX}/usr/lib/llvm/${CLANG_SLOT}/bin/clang++
	llvm_pkg_setup
	#tc-export CC CXX
	einfo $CXX
	python-single-r1_pkg_setup
}

src_prepare() {
	default
}

src_configure() {
	einfo $PATH
	CC="clang" CXX="clang++" strip-unsupported-flags
	local -x CC=${CHOST}-clang \
	local -x CXX=${CHOST}-clang++ \
	waf-utils_src_configure -vvv
}

src_compile() {
	waf-utils_src_compile
}

src_install () {
	waf-utils_src_install
}
