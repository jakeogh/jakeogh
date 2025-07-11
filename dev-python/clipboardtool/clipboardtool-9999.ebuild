# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

DESCRIPTION="X clipboard functions"
HOMEPAGE="https://github.com/jakeogh/clipboardtool"
EGIT_REPO_URI="https://github.com/jakeogh/clipboardtool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

# https://github.com/NikitaBeloglazov/clipman
	#dev-python/clipman[${PYTHON_USEDEP}]

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/mptool[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/htmlparser[${PYTHON_USEDEP}]
	dev-python/pyclip[${PYTHON_USEDEP}]
	dev-python/iritool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

