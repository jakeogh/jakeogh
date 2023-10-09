# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Common functions for @click"
HOMEPAGE="https://github.com/jakeogh/clicktool"
EGIT_REPO_URI="/home/sysskel/myapps/clicktool https://github.com/jakeogh/clicktool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-auto-help[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/globalverbose[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
