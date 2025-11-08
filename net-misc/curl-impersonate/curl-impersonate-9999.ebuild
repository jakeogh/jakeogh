# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit git-r3 cmake
DESCRIPTION="An active fork of curl-impersonate with more versions and build targets"
HOMEPAGE="https://github.com/lwthiker/curl-impersonate"
EGIT_REPO_URI="https://github.com/lexiforest/curl-impersonate"
SRC_URI="https://github.com/google/brotli/archive/refs/tags/v1.1.0.tar.gz -> brotli-1.1.0.tar.gz
                 https://github.com/google/boringssl/archive/673e61fc215b178a90c0e67858bbf162c8158993.zip -> boringssl-673e61fc215b178a90c0e67858bbf162c8158993.zip
                 https://github.com/nghttp2/nghttp2/releases/download/v1.63.0/nghttp2-1.63.0.tar.bz2 -> nghttp2-1.63.0.tar.bz2
                 https://github.com/ngtcp2/ngtcp2/releases/download/v1.11.0/ngtcp2-1.11.0.tar.bz2 -> ngtcp2-1.11.0.tar.bz2
                 https://github.com/ngtcp2/nghttp3/releases/download/v1.9.0/nghttp3-1.9.0.tar.bz2 -> nghttp3-1.9.0.tar.bz2
                 https://github.com/c-ares/c-ares/releases/download/v1.30.0/c-ares-1.30.0.tar.gz -> c-ares-1.30.0.tar.gz
                 https://github.com/curl/curl/archive/curl-8_7_1.tar.gz -> curl-8_7_1.tar.gz
                 https://github.com/curl/curl/archive/curl-8_15_0.tar.gz -> curl-8_15_0.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
IUSE+=""
RDEPEND="sys-libs/zlib
        app-arch/zstd"
DEPEND="${RDEPEND}"
BDEPEND="dev-build/cmake
        dev-build/ninja
        dev-lang/go"
S="${WORKDIR}/${P}"

src_prepare() {
        default
        if [[ -f chrome/patches/boringssl.patch ]]; then
                sed -i -e 's/    unsigned ext_index;/    unsigned ext_index = 0;/g' chrome/patches/boringssl.patch || die
        fi
        sed -i -e 's/add_libs="-pthread -lc++";/add_libs="-pthread -lstdc++";/g' Makefile.in || die
        sed -i -e 's/LDFLAGS="-lc++"//g' Makefile.in || die
        sed -i -e 's/config_flags="$$config_flags --disable-shared --enable-static";/config_flags="$$config_flags --disable-shared --enable-static --disable-tests";/g' Makefile.in || die
}

src_configure() {
        mkdir -p build || die
        cd build || die
        cp "${DISTDIR}"/brotli-1.1.0.tar.gz . || die
        cp "${DISTDIR}"/boringssl-673e61fc215b178a90c0e67858bbf162c8158993.zip . || die
        cp "${DISTDIR}"/nghttp2-1.63.0.tar.bz2 . || die
        cp "${DISTDIR}"/ngtcp2-1.11.0.tar.bz2 . || die
        cp "${DISTDIR}"/nghttp3-1.9.0.tar.bz2 . || die
        cp "${DISTDIR}"/c-ares-1.30.0.tar.gz cares-1.30.0.tar.gz || die
        cp "${DISTDIR}"/c-ares-1.30.0.tar.gz . || die
        cp "${DISTDIR}"/curl-8_7_1.tar.gz . || die
        cp "${DISTDIR}"/curl-8_15_0.tar.gz . || die
        LDFLAGS="" ../configure || die
}

src_compile() {
        cd build || die
        emake -j1 build
}

src_install() {
        dobin chrome/curl_chrome*
        cd build/curl-8_15_0/lib/.libs || die
        dolib.so libcurl-impersonate-chrome.so*
        cd "${S}"/build/curl-8_15_0/src/.libs || die
        dobin curl-impersonate-chrome
}

