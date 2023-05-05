# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Commpn pdf operations, print book etc"
HOMEPAGE="https://github.com/jakeogh/pdftool"
EGIT_REPO_URI="/home/cfg/_myapps/pdftool https://github.com/jakeogh/pdftool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/pikepdf[${PYTHON_USEDEP}]
	dev-python/pdfplumber[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
