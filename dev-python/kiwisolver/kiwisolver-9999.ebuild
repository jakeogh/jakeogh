# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )
inherit distutils-r1
inherit git-r3

DESCRIPTION="An efficient C++ implementation of the Cassowary constraint solving algorithm"
HOMEPAGE="https://github.com/nucleic/kiwi"
EGIT_REPO_URI="https://github.com/nucleic/kiwi.git"
LICENSE="Clear-BSD"
SLOT="0"
KEYWORDS=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
#S="${WORKDIR}"/kiwi-${PV}
