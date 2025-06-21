# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Python tool for building testable command-line interfaces"
HOMEPAGE="
	https://github.com/python-poetry/cleo/
	https://pypi.org/project/cleo/
"
NOPATCH_V="$(ver_cut 0-4)"
PATCH_V="$(ver_cut 6)"
MY_P="${PN}-${NOPATCH_V}${PATCH_V}"

SRC_URI="mirror://pypi/${P:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~ppc64 ~x86"

BDEPEND="
	test? (
		dev-python/clikit[${PYTHON_USEDEP}]
		dev-python/crashtest[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"

RDEPEND="
	dev-python/pylev[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

S="${WORKDIR}/${MY_P}"
