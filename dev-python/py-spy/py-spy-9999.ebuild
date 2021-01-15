# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

#CRATES="
#addr2line-0.11.0
#addr2line-0.13.0
#adler-0.2.3
#ahash-0.3.8
#ahash-0.4.5
#aho-corasick-0.7.13
#ansi_term-0.11.0
#arrayvec-0.4.12
#arrayvec-0.5.1
#atty-0.2.14
#autocfg-1.0.1
#backtrace-0.3.50
#benfred-read-process-memory-0.2.0
#bitflags-1.2.1
#bytemuck-1.4.1
#byteorder-1.3.4
#cc-1.0.59
#cfg-if-0.1.10
#cfg-if-1.0.0
#clap-2.33.3
#console-0.13.0
#const-random-0.1.8
#const-random-macro-0.1.8
#cpp_demangle-0.2.16
#cpp_demangle-0.3.1
#crc32fast-1.2.0
#crossbeam-channel-0.4.4
#crossbeam-utils-0.7.2
#ctrlc-3.1.6
#dashmap-3.11.10
#encode_unicode-0.3.6
#env_logger-0.7.1
#env_logger-0.8.2
#errno-0.1.8
#failure-0.1.8
#failure_derive-0.1.8
#fallible-iterator-0.2.0
#flate2-1.0.17
#getrandom-0.1.15
#gimli-0.20.0
#gimli-0.22.0
#glob-0.3.0
#goblin-0.1.3
#goblin-0.2.3
#hashbrown-0.8.2
#hashbrown-0.9.0
#heck-0.3.1
#hermit-abi-0.1.15
#humantime-2.0.1
#indexmap-1.6.0
#indicatif-0.15.0
#inferno-0.10.1
#itoa-0.4.6
#kernel32-sys-0.2.2
#lazy_static-1.4.0
#lazycell-1.3.0
#libc-0.2.80
#libm-0.2.1
#libproc-0.3.2
#libproc-0.7.2
#log-0.4.11
#lru-0.6.0
#mach-0.1.2
#mach-0.3.2
#mach_o_sys-0.1.1
#maybe-uninit-2.0.0
#memchr-2.3.3
#memmap-0.7.0
#miniz_oxide-0.4.1
#nix-0.17.0
#nodrop-0.1.14
#num-format-0.4.0
#num-traits-0.2.12
#num_cpus-1.13.0
#number_prefix-0.3.0
#object-0.17.0
#object-0.20.0
#parity-wasm-0.41.0
#plain-0.2.3
#ppv-lite86-0.2.9
#proc-macro-error-1.0.4
#proc-macro-error-attr-1.0.4
#proc-macro-hack-0.5.18
#proc-macro2-1.0.21
#proc-maps-0.1.6
#quick-xml-0.19.0
#quote-1.0.7
#rand-0.7.3
#rand_chacha-0.2.2
#rand_core-0.5.1
#rand_distr-0.3.0
#rand_hc-0.2.0
#redox_syscall-0.1.57
#regex-1.4.2
#regex-syntax-0.6.21
#remoteprocess-0.3.4
#remove_dir_all-0.5.3
#rgb-0.8.25
#rustc-demangle-0.1.16
#ryu-1.0.5
#scroll-0.10.1
#scroll_derive-0.10.2
#serde-1.0.116
#serde_derive-1.0.116
#serde_json-1.0.58
#smallvec-1.4.2
#stable_deref_trait-1.2.0
#str_stack-0.1.0
#strsim-0.8.0
#structopt-0.3.17
#structopt-derive-0.4.10
#syn-1.0.40
#synstructure-0.12.4
#target-lexicon-0.10.0
#tempfile-3.1.0
#term_size-0.3.2
#termcolor-1.1.0
#terminal_size-0.1.13
#termios-0.3.2
#textwrap-0.11.0
#thread_local-1.0.1
#unicode-segmentation-1.6.0
#unicode-width-0.1.8
#unicode-xid-0.2.1
#uuid-0.8.1
#vec_map-0.8.2
#version_check-0.9.2
#void-1.0.2
#wasi-0.9.0+wasi-snapshot-preview1
#winapi-0.2.8
#winapi-0.3.9
#winapi-build-0.1.1
#winapi-i686-pc-windows-gnu-0.4.0
#winapi-util-0.1.5
#winapi-x86_64-pc-windows-gnu-0.4.0
#"
#
#inherit cargo distutils-r1 git-r3
#
#DESCRIPTION="Sampling profiler for Python programs"
## Double check the homepage as the cargo_metadata crate
## does not provide this value so instead repository is used
#HOMEPAGE="https://github.com/benfred/py-spy"
#EGIT_REPO_URI="/home/cfg/_myapps/py_spy https://github.com/benfred/py-spy.git"
#SRC_URI="$(cargo_crate_uris ${CRATES})"
#RESTRICT="mirror"
## License set may be more restrictive as OR is not respected
## use cargo-license for a more accurate license picture
#LICENSE="0BSD Apache-2.0 Apache-2.0 WITH LLVM-exception BSD-2-Clause BSL-1.0 CDDL-1.0 MIT Unlicense Zlib"
#SLOT="0"
#KEYWORDS="~amd64"
#IUSE=""
#
#DEPEND=""
#RDEPEND=""
#
## Copyright 2017-2020 Gentoo Authors
## Distributed under the terms of the GNU General Public License v2

#EAPI=7

CRATES=""

inherit cargo

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="/home/cfg/_myapps/py_spy https://github.com/benfred/py-spy.git"
	inherit git-r3
else
	SRC_URI="
		https://github.com/benfred/py-spy/archive/v${PV}.tar.gz -> ${P}.tar.gz
		$(cargo_crate_uris ${CRATES})
		"
	KEYWORDS="~amd64 ~arm64 ~ppc64"
fi

DESCRIPTION="Sampling profiler for Python programs"
HOMEPAGE="https://github.com/benfred/py-spy"
RESTRICT=""
LICENSE="0BSD Apache-2.0 Apache-2.0 WITH LLVM-exception BSD-2-Clause BSL-1.0 CDDL-1.0 MIT Unlicense Zlib"
SLOT="0"

#IUSE="+capi"

#ASM_DEP=">=dev-lang/nasm-2.14"
#DEPEND="amd64? ( ${ASM_DEP} )"
#RDEPEND="capi? ( dev-util/cargo-c )"

DEPEND="sys-libs/libunwind"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		default
		cargo_src_unpack
	fi
}

src_compile() {
	export CARGO_HOME="${ECARGO_HOME}"
	local args=$(usex debug "" --release)

	cargo build ${args} \
		|| die "cargo build failed"

#	if use capi; then
#		cargo cbuild ${args} \
#			--prefix="/usr" --libdir="/usr/$(get_libdir)" --destdir="${ED}" \
#			|| die "cargo cbuild failed"
#	fi
}

src_install() {
	export CARGO_HOME="${ECARGO_HOME}"
	local args=$(usex debug "" --release)

#	if use capi; then
#		cargo cinstall $args \
#			--prefix="/usr" --libdir="/usr/$(get_libdir)" --destdir="${ED}" \
#			|| die "cargo cinstall failed"
#	fi

	cargo_src_install
}
