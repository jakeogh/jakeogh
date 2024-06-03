# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="Universal Python binding for the LMDB Lightning Database"
HOMEPAGE="https://github.com/jnwatson/py-lmdb"
EGIT_REPO_URI="https://github.com/jakeogh/py-lmdb.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

# cffi is used only on pypy, so no dep
DEPEND="
	>=dev-db/lmdb-0.9.28:=
"
RDEPEND="
	${DEPEND}
"

distutils_enable_sphinx docs
distutils_enable_tests pytest

src_compile() {
	local -x LMDB_FORCE_SYSTEM=1
	distutils-r1_src_compile
}

python_test() {
	rm -rf lmdb || die
	epytest tests
}
