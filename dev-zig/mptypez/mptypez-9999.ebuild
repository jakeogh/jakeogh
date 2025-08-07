# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="reads messagepacked bytes on stdin and prints their type and metadata to stdout"
HOMEPAGE="https://github.com/jakeogh/mptypez"
EGIT_REPO_URI="https://github.com/jakeogh/mptypez.git"

# Zig dependency
ZIG_MSGPACK_COMMIT="main"
SRC_URI="https://github.com/zigcc/zig-msgpack/archive/${ZIG_MSGPACK_COMMIT}.tar.gz -> zig-msgpack-${ZIG_MSGPACK_COMMIT}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND=">=dev-lang/zig-0.14.0"
RDEPEND=""

src_prepare() {
	default

	# Set up the zig dependencies manually
	local zig_cache_dir="${HOME}/.cache/zig"
	local dep_dir="${zig_cache_dir}/p"

	mkdir -p "${dep_dir}" || die

	# Extract the zig-msgpack dependency to the expected location
	local msgpack_hash="zig_msgpack-0.0.8-evvueB_ZAQBNRm7kdh1FslBxMvpu5WKvU2RrYhUY_Dne"
	local msgpack_dir="${dep_dir}/${msgpack_hash}"

	if [[ ! -d "${msgpack_dir}" ]]; then
		mkdir -p "${msgpack_dir}" || die
		tar -xzf "${DISTDIR}/zig-msgpack-${ZIG_MSGPACK_COMMIT}.tar.gz" \
			--strip-components=1 -C "${msgpack_dir}" || die "Failed to extract zig-msgpack"
	fi
}

src_compile() {
	# Build with dependencies already set up
	zig build -Doptimize=ReleaseSafe || die "compilation failed"
}

src_install() {
	dobin zig-out/bin/msgpack-reader

	# Create a symlink with the package name
	dosym msgpack-reader /usr/bin/mptypez
}
