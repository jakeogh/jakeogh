# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="python wrapper for zotify"
HOMEPAGE="https://github.com/jakeogh/zotify-wrapper"
EGIT_REPO_URI="https://github.com/jakeogh/zotify-wrapper.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/zotify[${PYTHON_USEDEP}]
	dev-python/zotify-wrapper-iridb-import[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
