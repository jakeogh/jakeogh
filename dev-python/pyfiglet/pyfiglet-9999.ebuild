# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# from https://github.com/gentoo/guru/raw/master/dev-python/pyfiglet/pyfiglet-9999.ebuild

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Pure-python FIGlet implementation"
HOMEPAGE="https://github.com/pwaller/pyfiglet"
EGIT_REPO_URI="https://github.com/pwaller/pyfiglet.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND=""
DEPEND="
	test? ( app-misc/toilet
			app-misc/figlet )"
DOCS=( README LICENSE )

python_test() {
	"${PYTHON}" pyfiglet/test.py || die "Testing failed with ${EPYTHON}"
}

src_install() {
	distutils-r1_src_install
	doman doc/pyfiglet.1
}
SLOT="0"

RESTRICT="mirror test"
