# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1


DESCRIPTION="status line functions"
HOMEPAGE="https://github.com/jakeogh/statustool"
EGIT_REPO_URI="https://github.com/jakeogh/statustool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/terminaltool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

