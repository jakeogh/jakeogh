# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="HTML parsing functions"
HOMEPAGE="https://github.com/jakeogh/htmlparser"
EGIT_REPO_URI="/home/sysskel/myapps/htmlparser https://github.com/jakeogh/htmlparser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

#	dev-python/pdfx[${PYTHON_USEDEP}]

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pdftool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"


