# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# from https://gpo.zugaina.org/Overlays/4nykey/dev-python/cattrs
EAPI=7

PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1
if [[ -z ${PV%%*9999} ]]; then
 inherit git-r3
 EGIT_REPO_URI="/home/sysskel/myapps/cattrs https://github.com/Tinche/${PN}.git"
 EGIT_BRANCH="structure-default"
 EGIT_SUBMODULES=( )
else
 inherit vcs-snapshot
 MY_PV="c047b66"
 [[ -n ${PV%%*_p*} ]] && MY_PV="v${PV}"
 SRC_URI="
  mirror://githubcl/Tinche/${PN}/tar.gz/${MY_PV} -> ${P}.tar.gz
 "
 RESTRICT="primaryuri"
 KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Complex custom class converters for attrs"
HOMEPAGE="https://github.com/Tinche/${PN}"

LICENSE="MIT"
SLOT="0"
IUSE="test"

RDEPEND="
 >=dev-python/attrs-17.3[${PYTHON_USEDEP}]
 $(python_gen_cond_dep 'dev-python/functools32[${PYTHON_USEDEP}]' -2)
 virtual/python-singledispatch[${PYTHON_USEDEP}]
 virtual/python-enum34[${PYTHON_USEDEP}]
 virtual/python-typing[${PYTHON_USEDEP}]
"
DEPEND="
 ${RDEPEND}
 dev-python/setuptools[${PYTHON_USEDEP}]
 test? (
  dev-python/hypothesis[${PYTHON_USEDEP}]
 )
"

python_test() {
 esetup.py test
}
