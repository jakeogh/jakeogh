# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy{,3} python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Access the libmagic file type identification library"
HOMEPAGE="https://github.com/ahupp/python-magic"
EGIT_REPO_URI="https://github.com/ahupp/python-magic.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="sys-apps/file[-python]"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND} )
"

python_test() {
	"${EPYTHON}" test/test.py -v || die "Tests fail with ${EPYTHON}"
}
