# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="HTML parsing functions"
HOMEPAGE="https://github.com/jakeogh/htmlparser"
EGIT_REPO_URI="https://github.com/jakeogh/htmlparser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

#	dev-python/pdfx[${PYTHON_USEDEP}]

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pdftool[${PYTHON_USEDEP}]
	dev-python/csvparser[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
