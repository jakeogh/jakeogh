# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3
inherit autotools

DESCRIPTION="Ion beam simulator library for ion optics and plasma extraction"
HOMEPAGE="https://ibsimu.sourceforge.net/"
EGIT_REPO_URI="git://ibsimu.git.sourceforge.net/gitroot/ibsimu/ibsimu"

LICENSE="GPL-2+"
SLOT="0"
IUSE="opengl umfpack"

RDEPEND="
	x11-libs/gtk+:3
	x11-libs/cairo
	sci-libs/gsl
	media-libs/libpng:=
	sys-libs/zlib
	opengl? ( virtual/opengl )
	umfpack? ( sci-libs/suitesparse:= )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
PATCHES=(
	"${FILESDIR}/gtkglarea.patch"
	"${FILESDIR}/umfpack-memory-estimate.patch"
)
src_prepare() {
	default
	touch src/ibsimu.cpp || die
	cat > src/id.hpp <<-EOF || die
		#define IBSIMU_GIT_ID "$(git log -1 --pretty=format:'%h, %ad')"
	EOF
	if use umfpack; then
		sed -i 's|suitesparse/||' m4/check_umfpack.m4 || die
	fi
	eautoreconf
}

src_configure() {
	local myconf=(
		--without-csg
		$(use_with opengl)
		$(usex umfpack --with-umfpack=/usr --without-umfpack)
	)
	econf "${myconf[@]}"
}
