# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3
inherit autotools
inherit toolchain-funcs

DESCRIPTION="A Client that groks URLs"
HOMEPAGE="https://curl.se/"
#SRC_URI="https://github.com/lwthiker/curl-impersonate/releases/download/v${PV}/libcurl-impersonate-v${PV}.x86_64-linux-gnu.tar.gz -> ${P}-bin.tar.gz"
#EGIT_REPO_URI="https://github.com/lwthiker/curl-impersonate"
EGIT_REPO_URI="https://github.com/lexiforest/curl-impersonate" # newer
SRC_URI="https://github.com/google/brotli/archive/refs/tags/v1.1.0.tar.gz -> brotli-1.1.0.tar.gz
		 https://github.com/google/boringssl/archive/cd95210465496ac2337b313cf49f607762abe286.zip -> boringssl-cd95210465496ac2337b313cf49f607762abe286.zip
		 https://github.com/nghttp2/nghttp2/releases/download/v1.63.0/nghttp2-1.63.0.tar.bz2 -> nghttp2-1.63.0.tar.bz2"

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
	sed -i '118 s/^/#/' curl-impersonate-9999/Makefile.in
	sed -i '119 s/^/#/' curl-impersonate-9999/Makefile.in
	sed -i '155 s/^/#/' curl-impersonate-9999/Makefile.in
	sed -i '156 s/^/#/' curl-impersonate-9999/Makefile.in
	sed -i -e 's/    unsigned ext_index;/    unsigned ext_index = 0;/g' curl-impersonate-9999/chrome/patches/boringssl.patch
	default
}

src_configure() {
	pwd
	ls -al
	echo "${P}"
	cd ./"${P}"
	pwd
	ls -al
	mkdir build || die
	cd build || die
	pwd
	cp -v /var/db/repos/gentoo/distfiles/brotli-1.1.0.tar.gz .
	cp -v /var/db/repos/gentoo/distfiles/boringssl-cd95210465496ac2337b313cf49f607762abe286.zip .
	cp -v /var/db/repos/gentoo/distfiles/nghttp2-1.63.0.tar.bz2 .
	ls -al
	../configure || die
}

src_compile() {
	pwd
	ls -al
	ls -al ./"${P}"
	cd ./"${P}"/build || die
	pwd
	make chrome-build || die
}

src_install() {
	pwd
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
