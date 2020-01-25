# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} )

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
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	sys-libs/libunwind
	"

RESTRICT="test"

src_prepare() {
	default
	rm -rf tests
}
