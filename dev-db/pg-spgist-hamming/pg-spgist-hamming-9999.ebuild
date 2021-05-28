# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )
POSTGRES_COMPAT=( 11 12 13 )

inherit postgres-multi
inherit git-r3

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/pg-spgist-hamming"
EGIT_REPO_URI="/home/cfg/_myapps/pg-spgist-hamming https://github.com/jakeogh/pg-spgist-hamming.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

#src_configure() {
#	#postgres-multi_foreach econf
#}

src_compile () {
	postgres-multi_foreach emake
}
