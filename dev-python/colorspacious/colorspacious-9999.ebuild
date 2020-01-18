# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Powerful, accurate, and easy-to-use Python library for colorspace conversions"
HOMEPAGE="https://colorspacious.readthedocs.org/en/latest/"
EGIT_REPO_URI="https://github.com/njsmith/colorspacious.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	app-arch/unzip
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test () {
	nosetests --all-modules || die "Tests fail with ${EPYTHON}"
}
