# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="common string manipulation functions"
HOMEPAGE="https://github.com/jakeogh/stringtool"
EGIT_REPO_URI="https://github.com/jakeogh/stringtool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/nltk[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
