# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit autotools python-r1
inherit git-r3

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="https://www.libimobiledevice.org/"
EGIT_REPO_URI="https://github.com/libimobiledevice/libimobiledevice-glue"

# While COPYING* doesn't mention 'or any later version', all the headers do, hence use +
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/1.0-6" # based on SONAME of libimobiledevice-1.0.so
KEYWORDS="amd64 ~arm ~arm64 ~loong ppc ~ppc64 ~riscv x86"
IUSE="doc gnutls python static-libs"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND=""
DEPEND="
	${RDEPEND}
"
# <cython-3 for bug #898666
BDEPEND=""

BUILD_DIR="${S}_build"


#	"${FILESDIR}/${P}-slibtool.patch"
#PATCHES=()

src_prepare() {
	default
	eautoreconf
}

#src_configure() {
#	local ECONF_SOURCE=${S}
#
#	local myeconfargs=( $(use_enable static-libs static) )
#	use gnutls && myeconfargs+=( --disable-openssl )
#
#	do_configure() {
#		mkdir -p "${BUILD_DIR}" || die
#		pushd "${BUILD_DIR}" >/dev/null || die
#		econf "${myeconfargs[@]}" "${@}"
#		popd >/dev/null || die
#	}
#
#	do_configure_python() {
#		# Bug 567916
#		local -x PYTHON_LDFLAGS="$(python_get_LIBS)"
#		do_configure "$@"
#	}
#
#	do_configure --without-cython
#	use python && python_foreach_impl do_configure_python
#}

#src_compile() {
#	python_compile() {
#		emake -C "${BUILD_DIR}"/cython \
#			VPATH="${S}/cython:$1/cython" \
#			imobiledevice_la_LIBADD="$1/src/libimobiledevice-glue-1.0.la"
#	}
#
#	emake -C "${BUILD_DIR}"
#	use python && python_foreach_impl python_compile "${BUILD_DIR}"
#
#	if use doc; then
#		doxygen "${BUILD_DIR}"/doxygen.cfg || die
#	fi
#}

#src_install() {
#	python_install() {
#		emake -C "${BUILD_DIR}/cython" install \
#			DESTDIR="${D}" \
#			VPATH="${S}/cython:$1/cython"
#	}
#
#	emake -C "${BUILD_DIR}" install DESTDIR="${D}"
#	use python && python_foreach_impl python_install "${BUILD_DIR}"
#	use doc && dodoc docs/html/*
#
#	if use python; then
#		insinto /usr/include/${PN}/cython
#		doins cython/imobiledevice.pxd
#	fi
#
#	find "${D}" -name '*.la' -delete || die
#}
