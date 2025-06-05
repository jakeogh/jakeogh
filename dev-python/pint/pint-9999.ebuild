# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1
inherit git-r3

DESCRIPTION="Operate and manipulate physical quantities in Python"
HOMEPAGE="https://github.com/hgrecco/pint"
EGIT_REPO_URI="/home/user/_myapps/pint https://github.com/hgrecco/pint.git"
#EGIT_BRANCH="debugging"
#EGIT_BRANCH="master"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="babel uncertainties test"


DEPEND=""
RDEPEND="${DEPEND}
	$(python_gen_cond_dep 'dev-python/importlib_resources[${PYTHON_USEDEP}]' pypy3)
	babel? ( dev-python/Babel[${PYTHON_USEDEP}] )
	uncertainties? ( dev-python/uncertainties[${PYTHON_USEDEP}] )
	dev-python/flexcache[${PYTHON_USEDEP}]
	dev-python/flexparser[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
"

RESTRICT="!test? ( test )"

distutils_enable_tests pytest

src_prepare () {
	default
	sed -i "s/PACKAGE_VERSION/${PV}/" ${S}/${PN}/__init__.py
}
