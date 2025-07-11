# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Simple MTP fuse filesystem driver"
HOMEPAGE="https://github.com/phatina/simple-mtpfs"
EGIT_REPO_URI="https://github.com/phatina/simple-mtpfs.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""


RDEPEND="
	media-libs/libmtp
	sys-fs/fuse:0"

DEPEND="${RDEPEND}"

BDEPEND="
	dev-build/autoconf-archive
	virtual/pkgconfig"


src_prepare() {
	default
	# The tarball doesn't contain ./configure, only configure.ac and
	# autogen.sh.
	eautoreconf
}

