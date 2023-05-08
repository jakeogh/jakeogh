# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )
POSTGRES_COMPAT=( 12 13 14 15 )


inherit distutils-r1
inherit postgres-multi
inherit git-r3

DESCRIPTION="postgres hamming distance"
HOMEPAGE="https://github.com/jakeogh/pg-spgist-hamming"
EGIT_REPO_URI="/home/cfg/_myapps/pg-spgist-hamming https://github.com/jakeogh/pg-spgist-hamming.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

BDEPEND="dev-db/postgresql:*"

#src_configure() {
#	#postgres-multi_foreach econf
#}

src_compile () {
	cd bktree
	ewarn `pwd`
	#postgres-multi_foreach emake
	make
}

src_install() {
	cd bktree
	ewarn `pwd`
	default
}
