# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Python IP address manipulation library"
HOMEPAGE="https://github.com/google/ipaddr-py https://pypi.org/project/ipaddr/"
EGIT_REPO_URI="https://github.com/google/ipaddr-py.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

python_prepare() {
	if python_is_python3; then
		2to3 -n -w --no-diffs *.py || die
	fi
}

python_test() {
	distutils_install_for_testing
	"${EPYTHON}" ipaddr_test.py || die "Tests fail with ${EPYTHON}"
}
