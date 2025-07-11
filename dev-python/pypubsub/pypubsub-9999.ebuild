# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="Python Publish-Subscribe Package"
HOMEPAGE="https://github.com/schollii/pypubsub"
#MY_PN="pypubsub"
#SRC_URI="https://github.com/schollii/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
EGIT_REPO_URI="https://github.com/schollii/pypubsub"
#S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.rst"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	py.test -v -v || die
}

distutils_enable_tests pytest
