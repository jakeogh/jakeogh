# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Cryptsetup wrapper to handle single passphrase on multiple LUKS devices"
HOMEPAGE="https://github.com/jakeogh/cryptsetup_open"
EGIT_REPO_URI="/home/sysskel/myapps/cryptsetup-open https://github.com/jakeogh/cryptsetup-open.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/clicktool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

