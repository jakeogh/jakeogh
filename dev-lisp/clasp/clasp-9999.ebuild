# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='threads(+)'

inherit eutils multilib git-r3 waf-utils python-single-r1 llvm

DESCRIPTION="clasp Common Lisp environment"
HOMEPAGE="https://github.com/clasp-developers/clasp"
EGIT_REPO_URI="https://github.com/clasp-developers/clasp"
#EGIT_BRANCH="dev"

LICENSE="LGPL-2.1+"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="threads"

CDEPEND="dev-libs/gmp:0
		virtual/libffi
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

src_test() {
	if has network-sandbox ${FEATURES}; then
		die 'FEATURES="-network-sandbox" is required to build clasp-9999'
		return 0;
	fi
	if ( shopt -s extglob; is-flagq '-g?(gdb)?([1-9])' ); then
		ewarn
		ewarn "You have enabled debug info (i.e. -g or -ggdb in your CFLAGS/CXXFLAGS)."
		ewarn "This causes the build to hang"
		ewarn
		die "Please try removing -g{,gdb}."
	fi

}

pkg_setup () {
	src_test
	llvm_pkg_setup
	python-single-r1_pkg_setup
}

src_prepare() {
	default
}

src_configure() {
	#CC="clang" CXX="clang++" strip-unsupported-flags
	CC="clang" CXX="clang++" waf-utils_src_configure
}

src_compile() {
	#waf-utils_src_compile --jobs 1 build_cboehm
	#waf-utils_src_compile --debug -v build_cboehm
	waf-utils_src_compile build_cboehm
}

src_install () {
	waf-utils_src_install install_cboehm
}
