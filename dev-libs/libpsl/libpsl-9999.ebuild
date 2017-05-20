# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# Copyright 2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

#inherit distutils-r1
inherit git-r3
inherit autotools

DESCRIPTION="libpsl"
HOMEPAGE="https://github.com/rockdaboot/libpsl"

EGIT_REPO_URI="https://github.com/rockdaboot/libpsl.git"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""


DEPEND=""

src_prepare() {
	default
	./autogen.sh || die
}

src_compile() {
	emake || die "Compile failed."
}

#src_install() {
#	emake DESTDIR="${D}" PREFIX=/usr install || die "Install failed."
#	
#}

