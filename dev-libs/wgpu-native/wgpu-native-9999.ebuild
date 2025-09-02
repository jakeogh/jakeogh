# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Native WebGPU implementation in Rust (C API over wgpu-core)"
HOMEPAGE="https://github.com/gfx-rs/wgpu-native"
EGIT_REPO_URI="https://github.com/gfx-rs/wgpu-native.git"
EGIT_SUBMODULES=( '*' )

LICENSE="Apache-2.0 MIT"
SLOT="0"
IUSE="static-libs"
KEYWORDS="~amd64 ~x86"

# Build-time toolchain
BDEPEND="
	>=dev-lang/rust-1.74
	virtual/pkgconfig
"

# Runtime deps
RDEPEND="
	media-libs/vulkan-loader
"

# ✅ No CRATES= or SRC_URI="$(cargo_crate_uris)" — forbidden!

# ✅ Use CARGO_MANIFEST_DIR to trigger cargo vendor
CARGO_MANIFEST_DIR="."

# ✅ Enable header generation
CARGO_FEATURES="generate-headers"

# Ensure consistent build dir
CARGO_TARGET_DIR="${WORKDIR}/target"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack  # This will run `cargo vendor` and fetch crates
}

src_prepare() {
	default
	mkdir -p "${CARGO_TARGET_DIR}"
}

src_compile() {
	env \
		CARGO_HOME="${WORKDIR}/cargo_home" \
		CARGO_TARGET_DIR="${CARGO_TARGET_DIR}" \
		cargo build --release --package wgpu-native --features "${CARGO_FEATURES}" \
		|| die "cargo build failed"
}

src_test() {
	: # disabled
}

src_install() {
	local libdir="/usr/$(get_libdir)"
	local target="${CARGO_TARGET_DIR}/release"

	# Install shared library
	if [[ -f "${target}/libwgpu_native.so" ]]; then
		dolib.so "${target}/libwgpu_native.so" || die "Failed to install libwgpu_native.so"
	else
		die "libwgpu_native.so not found in ${target}"
	fi

	# Install static lib (optional)
	if use static-libs && [[ -f "${target}/libwgpu_native.a" ]]; then
		insinto "${libdir}"
		doins "${target}/libwgpu_native.a" || die "Failed to install static lib"
	fi

	# Install generated header
	if [[ -f "${target}/include/webgpu.h" ]]; then
		insinto /usr/include/webgpu
		doins "${target}/include/webgpu.h" || die "Failed to install webgpu.h"
	else
		die "webgpu.h not generated! Did you enable 'generate-headers' feature?"
	fi

	# Install pkg-config file
	insinto "${libdir}/pkgconfig"
	newins - wgpu-native.pc <<-EOF || die
prefix=/usr
exec_prefix=\${prefix}
libdir=\${exec_prefix}/$(get_libdir)
includedir=\${prefix}/include

Name: wgpu-native
Description: Native WebGPU implementation (C API over wgpu-core)
Version: 9999
Libs: -L\${libdir} -lwgpu_native
Cflags: -I\${includedir}/webgpu
EOF

	dodoc README.md
}

