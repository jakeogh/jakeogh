# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1 git-r3

DESCRIPTION="Python subprocess interface"
HOMEPAGE="https://github.com/amoffat/sh"
EGIT_REPO_URI="https://github.com/amoffat/sh.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

#PATCHES=(
#	"${FILESDIR}/sh-1.12.9-python2-unicode-tests.patch"
#)

python_test() {
	${PYTHON} test.py || die
}
