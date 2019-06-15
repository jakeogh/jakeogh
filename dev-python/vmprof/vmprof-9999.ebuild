# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{3,4,5,6,7} )

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
