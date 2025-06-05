# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="Building powerful interactive command lines in Python"
HOMEPAGE="https://pypi.org/project/prompt_toolkit/ https://github.com/jonathanslenders/python-prompt-toolkit"
EGIT_REPO_URI="https://github.com/prompt-toolkit/python-prompt-toolkit.git"

SLOT="0"
LICENSE="BSD"
KEYWORDS=""
IUSE="test"

RDEPEND="
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
	dev-python/wcwidth[${PYTHON_USEDEP}]"

DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	py.test || die
}
