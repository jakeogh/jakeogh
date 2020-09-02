# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{7..9} pypy pypy3 )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A strictly RFC 4511 conforming LDAP V3 pure Python client"
HOMEPAGE="https://github.com/cannatag/ldap3 https://pypi.python.org/pypi/ldap3"
EGIT_REPO_URI="https://github.com/cannatag/ldap3.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="test"
# The tests are a mess, and the test config is not included in the
# PyPi tarball (see https://travis-ci.org/cannatag/ldap3 and
# https://github.com/cannatag/ldap3/blob/master/test/config.py).
RESTRICT="test"

RDEPEND="
	dev-python/pyasn1[${PYTHON_USEDEP}]"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		${RDEPEND} )"

python_test() {
	nosetests -v -s test || die
}
