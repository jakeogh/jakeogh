# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
#inherit distutils-r1
inherit cmake


DESCRIPTION="One of the fastest compact embeddable key-value ACID database without WAL"
HOMEPAGE="https://github.com/jakeogh/libmdbx"
EGIT_REPO_URI="/home/sysskel/myapps/libmdbx https://github.com/jakeogh/libmdbx.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

#src_prepare() {
#	default
#	xdg_src_prepare
#}

#src_configure() {
#	local -a mycmakeargs=(
#		-DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
#		-DBUILD_SHARED_LIBS:BOOL=ON
#		-DBUILD_TESTING:BOOL=$(usex test)
#		-DWITH_JAEGER:BOOL=$(usex jaeger)
#		-DWITH_PROMETHEUS:BOOL=$(usex prometheus)
#	)
#
#	cmake_src_configure
#}
