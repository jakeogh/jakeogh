# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy{,3} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Exclude specific directories from nosetests runs"
HOMEPAGE="https://github.com/kgrandis/nose-exclude"
EGIT_REPO_URI="https://github.com/kgrandis/nose-exclude.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/nose[${PYTHON_USEDEP}]"

python_test() {
	esetup.py test
}
