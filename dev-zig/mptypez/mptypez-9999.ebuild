# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="reads messagepacked bytes on stdin and prints their type and metadata to stdout"
HOMEPAGE="https://github.com/jakeogh/mptypez"
EGIT_REPO_URI="https://github.com/jakeogh/mptypez.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND=">=dev-lang/zig-0.14.0"
RDEPEND=""

src_compile() {
	zig build -Doptimize=ReleaseSafe || die "compilation failed"
}

src_install() {
	dobin zig-out/bin/msgpack-reader

	# Optionally create a symlink with the package name
	dosym msgpack-reader /usr/bin/mptypez
}
