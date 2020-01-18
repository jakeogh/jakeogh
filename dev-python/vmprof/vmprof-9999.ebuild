# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{7,8} )

inherit distutils-r1 git-r3

DESCRIPTION="vmprof Python client"
HOMEPAGE="https://vmprof.readthedocs.org/en/latest/"
EGIT_REPO_URI="https://github.com/vmprof/vmprof-python"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-libs/elfutils
	dev-libs/libdwarf
	dev-python/click
	dev-python/cffi
	dev-python/pytest
	dev-python/requests
	dev-python/six
	sys-libs/libunwind"

RESTRICT="test"

src_prepare() {
	default
	rm -rf tests
}
