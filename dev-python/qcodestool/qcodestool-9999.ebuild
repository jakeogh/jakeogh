# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="cli for Qcodes"
HOMEPAGE="https://github.com/jakeogh/qcodestool"
EGIT_REPO_URI="/home/sysskel/myapps/qcodestool https://github.com/jakeogh/qcodestool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/qcodes-contrib-drivers[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
