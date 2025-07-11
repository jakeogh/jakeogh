# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3 meson

DESCRIPTION="free EDA package"
HOMEPAGE="https://github.com/horizon-eda/horizon"
EGIT_REPO_URI="https://github.com/horizon-eda/horizon.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-libs/libgit2
	net-libs/cppzmq
	app-text/podofo
"

src_configure() {
	append-cxxflags -fpermissive
	meson_src_configure
}
