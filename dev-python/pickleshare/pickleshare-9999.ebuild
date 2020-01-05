# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A small 'shelve' like datastore with concurrency support"
HOMEPAGE="https://github.com/pickleshare/pickleshare"
EGIT_REPO_URI="https://github.com/pickleshare/pickleshare"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	$(python_gen_cond_dep 'dev-python/pathlib2[${PYTHON_USEDEP}]' 'python2*')
	>=dev-python/path-py-6.2[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

RESTRICT="test"

python_test() {
	py.test || die
}
