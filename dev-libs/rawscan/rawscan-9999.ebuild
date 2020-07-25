# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="High performance getline() alternative"
HOMEPAGE="https://github.com/ThePythonicCow/rawscan"
EGIT_REPO_URI="/home/cfg/_myapps/rawscan https://github.com/ThePythonicCow/rawscan.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND=""

DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/source"

src_install() {
	mkdir "${S}/build"
	cp "${WORKDIR}/RawscanConfigVersion.cmake" "${S}/build/"
	cmake_src_install
}
