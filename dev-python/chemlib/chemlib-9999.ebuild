# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="A comprehensive chemistry library for Python"
HOMEPAGE="https://github.com/harirakul/chemlib"
EGIT_REPO_URI="https://github.com/harirakul/chemlib.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/sympy[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
