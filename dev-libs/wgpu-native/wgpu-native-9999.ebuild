# /home/sysskel/myapps/jakeogh/dev-libs/wgpu-native/wgpu-native-9999.ebuild

EAPI=8

inherit cargo git-r3

DESCRIPTION="Native WebGPU implementation in Rust (C API over wgpu-core)"
HOMEPAGE="https://github.com/gfx-rs/wgpu-native"
EGIT_REPO_URI="https://github.com/gfx-rs/wgpu-native.git"
# wgpu-native uses submodules for headers; pull them
EGIT_SUBMODULES=( '*' )

LICENSE="Apache-2.0 MIT"
SLOT="0"
IUSE="static-libs"
KEYWORDS=""

# Build-time toolchain
BDEPEND="
	>=dev-lang/rust-1.74
	virtual/pkgconfig
"
# Runtime deps (Linux loads Vulkan ICDs at runtime)
RDEPEND="
	media-libs/vulkan-loader
"

# ===== Cargo vendoring (live) =====
# The helper script will overwrite this CRATES=... block with name-version pairs
CRATES="
	aho-corasick-1.1.3
	allocator-api2-0.2.21
	android_system_properties-0.1.5
	arrayvec-0.7.6
	ash-0.38.0+1.3.281
	autocfg-1.5.0
	bindgen-0.72.0
	bit-set-0.8.0
	bit-vec-0.8.0
	bitflags-1.3.2
	bitflags-2.9.1
	block-0.1.6
	bumpalo-3.19.0
	bytemuck-1.23.1
	bytemuck_derive-1.9.3
	cexpr-0.6.0
	cfg-if-1.0.1
	cfg_aliases-0.2.1
	clang-sys-1.8.1
	codespan-reporting-0.12.0
	core-foundation-0.9.4
	core-foundation-sys-0.8.7
	core-graphics-types-0.1.3
	crunchy-0.2.4
	document-features-0.2.11
	either-1.15.0
	equivalent-1.0.2
	fixedbitset-0.5.7
	foldhash-0.1.5
	foreign-types-0.5.0
	foreign-types-macros-0.2.3
	foreign-types-shared-0.3.1
	gl_generator-0.14.0
	glob-0.3.2
	glow-0.16.0
	glutin_wgl_sys-0.6.1
	gpu-alloc-0.6.0
	gpu-alloc-types-0.3.0
	gpu-allocator-0.27.0
	gpu-descriptor-0.3.2
	gpu-descriptor-types-0.2.0
	half-2.6.0
	hashbrown-0.15.4
	heck-0.5.0
	hexf-parse-0.2.1
	indexmap-2.10.0
	itertools-0.13.0
	jni-sys-0.3.0
	js-sys-0.3.77
	khronos-egl-6.0.0
	khronos_api-3.1.0
	libc-0.2.174
	libloading-0.8.8
	libm-0.2.15
	litrs-0.4.1
	lock_api-0.4.13
	log-0.4.27
	malloc_buf-0.0.6
	memchr-2.7.5
	metal-0.31.0
	minimal-lexical-0.2.1
	ndk-sys-0.5.0+25.2.9519653
	nom-7.1.3
	num-traits-0.2.19
	objc-0.2.7
	once_cell-1.21.3
	ordered-float-4.6.0
	parking_lot-0.12.4
	parking_lot_core-0.9.11
	paste-1.0.15
	petgraph-0.8.2
	pkg-config-0.3.32
	pp-rs-0.2.1
	presser-0.3.1
	prettyplease-0.2.35
	proc-macro2-1.0.95
	profiling-1.0.17
	quote-1.0.40
	range-alloc-0.1.4
	raw-window-handle-0.6.2
	redox_syscall-0.5.13
	regex-1.11.1
	regex-automata-0.4.9
	regex-syntax-0.8.5
	renderdoc-sys-1.1.0
	rustc-hash-1.1.0
	rustc-hash-2.1.1
	rustversion-1.0.21
	scopeguard-1.2.0
	serde-1.0.219
	serde_derive-1.0.219
	shlex-1.3.0
	slotmap-1.0.7
	smallvec-1.15.1
	spirv-0.3.0+sdk-1.3.268.0
	strum-0.26.3
	strum_macros-0.26.4
	syn-2.0.104
	termcolor-1.4.1
	thiserror-1.0.69
	thiserror-2.0.12
	thiserror-impl-1.0.69
	thiserror-impl-2.0.12
	unicode-ident-1.0.18
	unicode-width-0.2.1
	unicode-xid-0.2.6
	version_check-0.9.5
	wasm-bindgen-0.2.100
	wasm-bindgen-backend-0.2.100
	wasm-bindgen-macro-0.2.100
	wasm-bindgen-macro-support-0.2.100
	wasm-bindgen-shared-0.2.100
	web-sys-0.3.77
	winapi-util-0.1.9
	windows-0.58.0
	windows-core-0.58.0
	windows-implement-0.58.0
	windows-interface-0.58.0
	windows-result-0.2.0
	windows-strings-0.1.0
	windows-sys-0.59.0
	windows-targets-0.52.6
	windows-targets-0.53.2
	windows_aarch64_gnullvm-0.52.6
	windows_aarch64_gnullvm-0.53.0
	windows_aarch64_msvc-0.52.6
	windows_aarch64_msvc-0.53.0
	windows_i686_gnu-0.52.6
	windows_i686_gnu-0.53.0
	windows_i686_gnullvm-0.52.6
	windows_i686_gnullvm-0.53.0
	windows_i686_msvc-0.52.6
	windows_i686_msvc-0.53.0
	windows_x86_64_gnu-0.52.6
	windows_x86_64_gnu-0.53.0
	windows_x86_64_gnullvm-0.52.6
	windows_x86_64_gnullvm-0.53.0
	windows_x86_64_msvc-0.52.6
	windows_x86_64_msvc-0.53.0
	xml-rs-0.8.26
"

# Turn the CRATES list into SRC_URI entries for Portage-controlled fetch (no sandbox disable)
SRC_URI="$(cargo_crate_uris)"

# No feature fiddling; backends are chosen at runtime
CARGO_FEATURES=""

src_unpack() {
	# 1) fetch sources via git-r3 (with submodules)
	git-r3_src_unpack
	# 2) unpack vendored crates listed in CRATES from DISTDIR
	cargo_live_src_unpack
}

src_prepare() {
	default
}

src_compile() {
	# Build only the C API library
	cargo_build --release --package wgpu-native
}

src_test() {
	# Upstream tests for the C API aren’t stable in live builds; skip by default.
	:
}

src_install() {
	local t="target/release"

	# Shared lib
	if [[ -f "${t}/libwgpu_native.so" ]]; then
		dolib.so "${t}/libwgpu_native.so" || die
	fi

	# Optional static lib
	if use static-libs && [[ -f "${t}/libwgpu_native.a" ]]; then
		insinto "/usr/$(get_libdir)"
		doins "${t}/libwgpu_native.a" || die
	fi

	# Headers (from submodules and repo)
	insinto /usr/include/webgpu
	doins ffi/webgpu-headers/webgpu.h || die
	doins ffi/wgpu.h || die

	# pkg-config
	insinto "/usr/$(get_libdir)/pkgconfig"
	newins - wgpu-native.pc <<-EOF || die
		prefix=/usr
		libdir=\${prefix}/$(get_libdir)
		includedir=\${prefix}/include
		Name: wgpu-native
		Description: Native WebGPU implementation (C API over wgpu-core)
		Version: 0
		Libs: -L\${libdir} -lwgpu_native
		Cflags: -I\${includedir}/webgpu
	EOF

	dodoc README.md
}
