# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1
inherit git-r3

DESCRIPTION="A collection of C++ headers which make it easier to write Python C extension modules"
HOMEPAGE="https://github.com/nucleic/cppy"
EGIT_REPO_URI="https://github.com/nucleic/cppy.git"
LICENSE="Clear-BSD"
SLOT="0"
KEYWORDS=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
#S="${WORKDIR}"/kiwi-${PV}
