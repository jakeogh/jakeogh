# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='threads(+)'

inherit eutils multilib git-r3 waf-utils python-single-r1 llvm cmake-utils

## test phase only works if ecls already installed #516876
#RESTRICT="test"

#MY_P=ecl-${PV}

DESCRIPTION="clasp Common Lisp environment"
HOMEPAGE="https://github.com/clasp-developers/clasp"
EGIT_REPO_URI="https://github.com/clasp-developers/clasp"

LICENSE="LGPL-2.1+"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="threads"
#IUSE="cxx debug emacs gengc precisegc cpu_flags_x86_sse +threads +unicode X"

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
#		app-text/texi2html
#		emacs? ( virtual/emacs >=app-eselect/eselect-emacs-1.12 )"

RDEPEND="${CDEPEND}"

LLVM_MAX_SLOT=6

#S="${WORKDIR}"/${MY_P}

#PATCHES=(
#	"${FILESDIR}/${P}-headers-gentoo.patch"
#	"${FILESDIR}/${P}-build.patch"
#)

pkg_setup () {
	llvm_pkg_setup
	python-single-r1_pkg_setup
#	if use gengc || use precisegc ; then
#		ewarn "You have enabled the generational garbage collector or"
#		ewarn "the precise collection routines. These features are not very stable"
#		ewarn "at the moment and may cause crashes."
#		ewarn "Don't enable them unless you know what you're doing."
#	fi
}

src_prepare() {
	default
	cmake-utils_src_prepare
#	cp "${EPREFIX}"/usr/share/common-lisp/source/asdf/build/asdf.lisp contrib/asdf/ || die
}

src_configure() {
	waf-utils_src_configure
#	econf \
#		--with-system-gmp \
#		--enable-boehm=system \
#		--enable-longdouble=yes \
#		--with-dffi \
#		$(use_with cxx) \
#		$(use_enable gengc) \
#		$(use_enable precisegc) \
#		$(use_with debug debug-cflags) \
#		$(use_enable libatomic libatomic system) \
#		$(use_with cpu_flags_x86_sse sse) \
#		$(use_enable threads) \
#		$(use_with threads __thread) \
#		$(use_enable unicode) \
#		$(use_with unicode unicode-names) \
#		$(use_with X x)
}

src_compile() {
	waf-utils_src_compile
#	if use emacs; then
#		local ETAGS=$(eselect --brief etags list | sed -ne '/emacs/{p;q}')
#		[[ -n ${ETAGS} ]] || die "No etags implementation found"
#		pushd build > /dev/null || die
#		emake ETAGS=${ETAGS} TAGS
#		popd > /dev/null
#	else
#		touch build/TAGS
#	fi
#
#	#parallel make fails
#	emake -j1 || die "Compilation failed"
}

src_install () {
	waf-utils_src_install
#	emake DESTDIR="${D}" install || die "Installation failed"
#
#	dodoc README.md CHANGELOG
#	dodoc "${FILESDIR}"/README.Gentoo
#	pushd build/doc
#	newman ecl.man ecl.1
#	newman ecl-config.man ecl-config.1
#	popd
}
