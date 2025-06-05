# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/caizhengxin/python-libpcap"
EGIT_REPO_URI="https://github.com/caizhengxin/python-libpcap.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
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
