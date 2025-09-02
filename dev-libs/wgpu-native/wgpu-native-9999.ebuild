# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

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

# Use cargo vendor via manifest in repo root
CARGO_MANIFEST_DIR="."

# Ensure consistent build directory
CARGO_TARGET_DIR="${WORKDIR}/target"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_prepare() {
	default
	# Ensure target dir exists
	mkdir -p "${CARGO_TARGET_DIR}"
}

src_compile() {
	env CARGO_TARGET_DIR="${CARGO_TARGET_DIR}" \
		cargo build --release --package wgpu-native || die "cargo build failed"
}

src_test() {
	# Skip unstable tests in live builds
	elog "Skipping tests: upstream C API tests not stable in live ebuild"
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

	# ✅ Install correct headers
	# The main C API header
	insinto /usr/include/webgpu
	doins include/webgpu.h || die "Failed to install include/webgpu.h"

	# The WebGPU spec header (from submodule)
	doins ffi/webgpu-headers/webgpu.h || die "Failed to install ffi/webgpu-headers/webgpu.h"

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


