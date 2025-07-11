# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="Syntax-highlighting, declarative and composable pretty printer"
HOMEPAGE="https://github.com/tommikaikkonen/prettyprinter"
EGIT_REPO_URI="https://github.com/tommikaikkonen/prettyprinter.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/colorful[${PYTHON_USEDEP}]"

#	dev-python/pytest-runner[${PYTHON_USEDEP}]
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install
	find "${ED}" -name '*.pth' -delete || die
}
