# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ZIG_SLOT="0.14"
inherit git-r3 zig

DESCRIPTION="reads messagepacked bytes on stdin and prints their type and metadata to stdout"
HOMEPAGE="https://github.com/jakeogh/mptypez"
EGIT_REPO_URI="https://github.com/jakeogh/mptypez.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

# Zig dependencies handled by the zig eclass
declare -A ZBS_DEPENDENCIES=(
	["zig_msgpack-0.0.8-evvueB_ZAQBNRm7kdh1FslBxMvpu5WKvU2RrYhUY_Dne.tar.gz"]="https://github.com/zigcc/zig-msgpack/archive/main.tar.gz"
)

src_unpack() {
	git-r3_src_unpack
	zig_src_unpack
}

src_install() {
	zig_src_install
	# Create a symlink with the package name
	dosym msgpack-reader /usr/bin/mptypez
}
