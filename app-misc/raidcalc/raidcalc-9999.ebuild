# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3

DESCRIPTION="Calculate RAID size given a geometry"
HOMEPAGE="https://github.com/jakeogh/raidcalc"
EGIT_REPO_URI="/home/cfg/_myapps/raidcalc https://github.com/jakeogh/raidcalc.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/cytoolz[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
#	test? ( dev-python/nose[${PYTHON_USEDEP}]
#		>=dev-python/toolz-0.8[${PYTHON_USEDEP}] )"

#python_compile() {
#	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing"
#	distutils-r1_python_compile
#}

#python_test() {
#	pushd "${BUILD_DIR}"/lib/ > /dev/null || die
#	PYTHONPATH=.:${PN} nosetests --with-doctest ${PN} || die "tests failed under ${EPYTHON}"
#	popd > /dev/null || die
#}
