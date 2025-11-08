# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit git-r3
inherit autotools
inherit toolchain-funcs
DESCRIPTION="An active fork of curl-impersonate with more versions and build targets"
HOMEPAGE="https://github.com/lwthiker/curl-impersonate"
EGIT_REPO_URI="https://github.com/lexiforest/curl-impersonate"
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
S="${WORKDIR}/${P}"

src_prepare() {
        default
        # Patch files after they're checked out
        if [[ -f chrome/patches/boringssl.patch ]]; then
                sed -i -e 's/    unsigned ext_index;/    unsigned ext_index = 0;/g' chrome/patches/boringssl.patch || die
        fi
        sed -i -e 's/add_libs="-pthread -lc++";/add_libs="-pthread -lstdc++";/g' Makefile.in || die
        sed -i -e 's/LDFLAGS="-lc++"//g' Makefile.in || die
}

src_configure() {
        mkdir -p build || die
        cd build || die
        cp -v "${DISTDIR}"/brotli-1.1.0.tar.gz . || die
        cp -v "${DISTDIR}"/boringssl-cd95210465496ac2337b313cf49f607762abe286.zip . || die
        cp -v "${DISTDIR}"/nghttp2-1.63.0.tar.bz2 . || die
        cp -v "${DISTDIR}"/curl-8_7_1.tar.gz . || die
        ../configure || die
}

src_compile() {
        cd build || die
        emake chrome-build
}

src_install() {
        cd chrome || die
        dobin curl_chrome*
        cd "${S}"/build/curl-8_7_1/lib/.libs || die
        dolib.so libcurl-impersonate-chrome.so*
        cd "${S}"/build/curl-8_7_1/src/.libs || die
        dobin curl-impersonate-chrome
}
