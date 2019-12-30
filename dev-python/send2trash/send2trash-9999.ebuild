# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy )

inherit distutils-r1
inherit git-r3

#MY_PN="send2trash"
#MY_P="${MY_PN}-${PV}"

DESCRIPTION="Sends files to the Trash (or Recycle Bin)"
HOMEPAGE="
	https://pypi.org/project/Send2Trash/
	https://github.com/hsoft/send2trash"
EGIT_REPO_URI="https://github.com/hsoft/send2trash"

SLOT="0"
LICENSE="BSD"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

#S="${WORKDIR}"/${MY_P}

#PATCHES=(
#	"${FILESDIR}/${P}-fix-broken-tests-on-py2.patch"
#)

python_test() {
	${EPYTHON} setup.py test
}
