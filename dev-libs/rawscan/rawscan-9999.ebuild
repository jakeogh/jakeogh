# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="High performance getline() alternative"
HOMEPAGE="https://github.com/ThePythonicCow/rawscan"
EGIT_REPO_URI="/home/sysskel/myapps/rawscan https://github.com/ThePythonicCow/rawscan.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND=""

DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/source"

src_install() {
	mkdir "${S}/build"
	cp "${BUILD_DIR}/RawscanConfigVersion.cmake" "${S}/build/"
	cmake_src_install
}
