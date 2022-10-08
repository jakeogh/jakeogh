# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3

#inherit xdg

DESCRIPTION="Minimal zig binary"
HOMEPAGE="https://github.com/jakeogh/zig-minimal"
EGIT_REPO_URI="/home/cfg/_myapps/zig-minimal https://github.com/jakeogh/zig-minimal.git"

MY_P="${P/-/_}"
MY_PN="${PN/-/_}"
#MY_S=""${WORKDIR}/${MY_P}""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-util/elfkickers
"

src_compile() {
	#zig build-exe ${PN}.zig --strip || die
	echo ${S}/${MY_PN}/${MY_PN}.zig
	#zig build-exe ${S}/${MY_PN}/${MY_PN}.zig --strip || die
	zig build-exe ${S}/${MY_PN}/${MY_PN}.zig -O ReleaseSmall --single-threaded --strip || die
	strip ${S}/${MY_PN}/${MY_PN} || die
	#zig build-exe zig_minimal.zig --strip || die
}

#src_prepare() {
#	default
#	xdg_src_prepare
#}
