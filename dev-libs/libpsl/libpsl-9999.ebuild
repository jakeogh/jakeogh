# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
PYTHON_COMPAT=( python2_7 )

inherit git-r3
#inherit autotools
inherit python-single-r1

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
