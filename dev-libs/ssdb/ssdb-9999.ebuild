# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# from https://github.com/longlene/clx/tree/master/dev-db/ssdb

EAPI=7
#PYTHON_COMPAT=( python3_{8..9} )

inherit git-r3
#inherit distutils
inherit eutils user

DESCRIPTION="A fast NoSQL database on-disk alternative to Redis"
HOMEPAGE="https://ssdb.io"
#SRC_URI="https://github.com/ideawu/ssdb/archive/${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="/home/cfg/_myapps/ssdb https://github.com/jakeogh/ssdb.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="dev-libs/leveldb"

pkg_setup() {
	enewgroup ssdb 75
	enewuser ssdb 75 -1 /var/lib/ssdb ssdb
}

src_prepare() {
	epatch \
	"${FILESDIR}"/${PN}-9999-config.patch
	eapply_user
}

src_install() {
	insinto /etc
	doins ssdb.conf ssdb_slave.conf
	use prefix || fowners ssdb:ssdb /etc/ssdb.conf
	fperms 0644 /etc/ssdb.conf

	insinto /usr/include
	doins src/client/SSDB_client.h
	dolib.a src/client/libssdb-client.a

	#insinto /usr/include/ssdb
	#doins src/ssdb/{const.h,binlog.h,iterator.h,options.h,ssdb.h,ttl.h}
	#dolib.a src/ssdb/libssdb.a

	#insinto /usr/include/util
	#doins src/util/{config.h,bytes.h,strings.h}
	#dolib.a src/util/libutil.a

	newconfd "${FILESDIR}/ssdb.confd" ssdb
	newinitd "${FILESDIR}/ssdb.initd" ssdb

	dosbin ssdb-server tools/ssdb-{bench,dump,migrate,repair} tools/leveldb-import

	insinto /usr/$(get_libdir)/ssdb/tools
	doins -r tools/ssdb-cli{,.cpy} tools/ssdb_cli

	insinto /usr/$(get_libdir)/ssdb/deps
	doins -r deps/cpy
	dosym /usr/$(get_libdir)/ssdb/tools/ssdb-cli /usr/bin/ssdb-cli

	dodoc README.md

	keepdir /var/{log,lib}/ssdb
}
