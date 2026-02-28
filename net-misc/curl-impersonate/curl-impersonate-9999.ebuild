# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit git-r3
DESCRIPTION="An active fork of curl-impersonate with more versions and build targets"
HOMEPAGE="https://github.com/lexiforest/curl-impersonate"
EGIT_REPO_URI="https://github.com/lexiforest/curl-impersonate"

# All tarballs the Makefile would otherwise try to curl -L during build.
# Versions must match Makefile.in in the repo HEAD.
SRC_URI="
	https://github.com/madler/zlib/releases/download/v1.3.1/zlib-1.3.1.tar.gz
	https://github.com/facebook/zstd/releases/download/v1.5.6/zstd-1.5.6.tar.gz
	https://github.com/google/brotli/archive/refs/tags/v1.2.0.tar.gz -> brotli-1.2.0.tar.gz
	https://github.com/google/boringssl/archive/673e61fc215b178a90c0e67858bbf162c8158993.zip -> boringssl-673e61fc215b178a90c0e67858bbf162c8158993.zip
	https://github.com/nghttp2/nghttp2/releases/download/v1.63.0/nghttp2-1.63.0.tar.bz2
	https://github.com/ngtcp2/ngtcp2/releases/download/v1.20.0/ngtcp2-1.20.0.tar.bz2
	https://github.com/ngtcp2/nghttp3/releases/download/v1.15.0/nghttp3-1.15.0.tar.bz2
	https://ftp.gnu.org/gnu/libunistring/libunistring-1.1.tar.gz
	https://ftp.gnu.org/gnu/libidn/libidn2-2.3.7.tar.gz
	https://github.com/curl/curl/archive/curl-8_15_0.tar.gz
"

LICENSE="MIT"
SLOT="0"
RESTRICT="test"
RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	dev-build/ninja
	dev-lang/go
	app-arch/unzip
"
S="${WORKDIR}/${P}"

src_prepare() {
	default
	# Fix uninitialized variable warning in boringssl patch
	if [[ -f patches/boringssl.patch ]]; then
		sed -i -e 's/    unsigned ext_index;/    unsigned ext_index = 0;/g' patches/boringssl.patch || die
	fi
}

src_configure() {
	mkdir -p build || die
	cd build || die

	# Pre-place all tarballs the Makefile expects to download
	local f
	for f in \
		zlib-1.3.1.tar.gz \
		zstd-1.5.6.tar.gz \
		brotli-1.2.0.tar.gz \
		boringssl-673e61fc215b178a90c0e67858bbf162c8158993.zip \
		nghttp2-1.63.0.tar.bz2 \
		ngtcp2-1.20.0.tar.bz2 \
		nghttp3-1.15.0.tar.bz2 \
		libunistring-1.1.tar.gz \
		libidn2-2.3.7.tar.gz \
		curl-8_15_0.tar.gz \
	; do
		cp "${DISTDIR}/${f}" . || die "Failed to copy ${f}"
	done

	LDFLAGS="" ../configure --prefix=/usr || die
}

src_compile() {
	cd build || die
	emake -j1 build
}

src_install() {
	cd build || die
	emake install-strip DESTDIR="${D}" || die
}
