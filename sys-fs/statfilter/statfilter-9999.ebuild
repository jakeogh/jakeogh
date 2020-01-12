# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1 git-r3

DESCRIPTION="Filter files from stdin to stdout based on stat(1)"
HOMEPAGE="https://github.com/jakeogh/statfilter"
EGIT_REPO_URI="/home/cfg/_myapps/statfilter https://github.com/jakeogh/statfilter.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
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
