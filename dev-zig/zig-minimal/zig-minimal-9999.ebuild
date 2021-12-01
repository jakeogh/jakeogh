# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3

#inherit xdg

DESCRIPTION="Minimal zig binary"
HOMEPAGE="https://github.com/jakeogh/zig-minimal"
EGIT_REPO_URI="/home/cfg/_myapps/zig-minimal https://github.com/jakeogh/zig-minimal.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

src_compile() {
	zig build-exe ${PN} --strip || die
}

#src_prepare() {
#	default
#	xdg_src_prepare
#}
