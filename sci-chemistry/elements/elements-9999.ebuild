# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="List elements"
HOMEPAGE="https://github.com/jakeogh/elements"
EGIT_REPO_URI="https://github.com/jakeogh/elements.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	sci-chemistry/mendeleev[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]

	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/texttable[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
