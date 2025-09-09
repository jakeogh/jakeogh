# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Framework for building extensible applications"
HOMEPAGE="
	https://docs.enthought.com/envisage/
	https://github.com/enthought/envisage/
	https://pypi.org/project/envisage/
"
EGIT_REPO_URI="https://github.com/enthought/envisage.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	>=dev-python/traits-6.2.0[${PYTHON_USEDEP}]
	>=dev-python/apptools-4.0.0[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/traitsui[${PYTHON_USEDEP}]
		dev-python/pyface[${PYTHON_USEDEP}]
	)
"

DEPEND="${RDEPEND}"

IUSE="test"
RESTRICT="!test? ( test )"

distutils_enable_tests unittest

python_test() {
	eunittest discover -v envisage
}

