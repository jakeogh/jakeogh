# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3
inherit autotools
inherit toolchain-funcs

DESCRIPTION="An active fork of curl-impersonate with more versions and build targets"
HOMEPAGE="https://github.com/lwthiker/curl-impersonate"
#EGIT_REPO_URI="https://github.com/lwthiker/curl-impersonate"
EGIT_REPO_URI="https://github.com/lexiforest/curl-impersonate" # newer
SRC_URI="https://github.com/google/brotli/archive/refs/tags/v1.1.0.tar.gz -> brotli-1.1.0.tar.gz
		 https://github.com/google/boringssl/archive/cd95210465496ac2337b313cf49f607762abe286.zip -> boringssl-cd95210465496ac2337b313cf49f607762abe286.zip
		 https://github.com/nghttp2/nghttp2/releases/download/v1.63.0/nghttp2-1.63.0.tar.bz2 -> nghttp2-1.63.0.tar.bz2
		 https://github.com/curl/curl/archive/curl-8_7_1.tar.gz -> curl-8_7_1.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT=""
IUSE+=""

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_prepare() {
	# https://github.com/lexiforest/curl-impersonate/issues/81
	sed -i -e 's/    unsigned ext_index;/    unsigned ext_index = 0;/g' curl-impersonate-9999/chrome/patches/boringssl.patch
	#sed -i -e 's/add_libs="-pthread -lc++";/add_libs="-pthread";/g' curl-impersonate-9999/Makefile.in
	sed -i -e 's/add_libs="-pthread -lstdc++";/add_libs="-pthread";/g' curl-impersonate-9999/Makefile.in
	sed -i -e 's/LDFLAGS="-lc++"//g' curl-impersonate-9999/Makefile.in
	default
}

src_configure() {
	cd ./"${P}"
	mkdir build || die
	cd build || die
	cp -v /var/db/repos/gentoo/distfiles/brotli-1.1.0.tar.gz .
	cp -v /var/db/repos/gentoo/distfiles/boringssl-cd95210465496ac2337b313cf49f607762abe286.zip .
	cp -v /var/db/repos/gentoo/distfiles/nghttp2-1.63.0.tar.bz2 .
	cp -v /var/db/repos/gentoo/distfiles/curl-8_7_1.tar.gz .
	../configure || die
}

src_compile() {
	cd ./"${P}"/build || die
	make chrome-build || die
}

src_install() {
	#pwd
	ls -al
	make chrome-install || die
}

#	insinto /usr/lib64
#	doins libcurl-impersonate-chrome.la
#	doins libcurl-impersonate-chrome.so
#	doins libcurl-impersonate-chrome.so.4
#	doins libcurl-impersonate-chrome.so.4.8.0
#	doins libcurl-impersonate-ff.a
#	doins libcurl-impersonate-ff.la
#	doins libcurl-impersonate-ff.so
#	doins libcurl-impersonate-ff.so.4
#	doins libcurl-impersonate-ff.so.4.8.0
#}
