# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit meson python-any-r1 git-r3

DESCRIPTION="Common code base for all Kiwix ports"
HOMEPAGE="https://www.kiwix.org/ https://github.com/kiwix/libkiwix"
EGIT_REPO_URI="https://github.com/kiwix/libkiwix.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	>=app-arch/libzim-9.0.0
	dev-libs/icu:=
	dev-libs/pugixml
	>=net-libs/libmicrohttpd-0.9.71
	net-misc/curl
	net-misc/aria2
	sys-libs/zlib
"

DEPEND="
	${RDEPEND}
	>=dev-cpp/mustache-4.1
"

BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
	test? ( dev-cpp/gtest )
"

src_configure() {
	local emesonargs=(
		-Dwerror=false
	)
	meson_src_configure
}

src_test() {
	meson_src_test
}

