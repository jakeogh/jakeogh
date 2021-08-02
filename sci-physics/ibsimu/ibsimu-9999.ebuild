# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit toolchain-funcs
inherit autotools

DESCRIPTION="Ion beam simulator"
HOMEPAGE="http://ibsimu.sourceforge.net/index.html"
EGIT_REPO_URI="/home/user/_myapps/ibsimu git://ibsimu.git.sourceforge.net/gitroot/ibsimu/ibsimu"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""

RDEPEND='
	x11-libs/gtkglext
	sci-libs/suitesparse
	media-gfx/opencsg
'

src_prepare() {
	default
	touch src/ibsimu.cpp || die
	echo -n "#define IBSIMU_GIT_ID \"" > src/id.hpp || die
	git log -1 --pretty=format:"%h, %ad" >> src/id.hpp || die
	echo "\"" >> src/id.hpp || die
	eautoreconf
}

src_configure() {
	econf
}

src_install() {
	default
}
