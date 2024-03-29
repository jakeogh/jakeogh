# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=4

MY_P=${P/td/t}-pre
DESCRIPTION="Webster's Revised Unabridged Dictionary (1913) for dict"
HOMEPAGE="http://www.dict.org/"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ppc ppc64 sparc x86"

DEPEND=">=app-text/dictd-1.5.5"

RDEPEND="$DEPEND"

S=${WORKDIR}

src_install() {
	insinto /usr/lib/dict
	doins web1913.dict.dz web1913.index || die
}
