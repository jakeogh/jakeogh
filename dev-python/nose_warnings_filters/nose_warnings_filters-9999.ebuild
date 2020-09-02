# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{7..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A python module to inject warning filters during nosetest"
HOMEPAGE="https://github.com/Carreau/nose_warnings_filters"
EGIT_REPO_URI="https://github.com/Carreau/nose_warnings_filters.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/nose[${PYTHON_USEDEP}]"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND} )"

python_test() {
	# nose_warnings_filters doesn't have a proper
	# testing suite, hence we run the only testing
	# script available
	distutils_install_for_testing
	cd "${TEST_DIR}"/lib || die
	"${EPYTHON}" "${S}"/${PN}/testing/test_config.py || die "Failed running test script"
}
