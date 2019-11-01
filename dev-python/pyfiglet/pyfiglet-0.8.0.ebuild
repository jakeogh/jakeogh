# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Pure-python FIGlet implementation"
HOMEPAGE="https://github.com/pwaller/pyfiglet"
SRC_URI="https://github.com/pwaller/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
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
