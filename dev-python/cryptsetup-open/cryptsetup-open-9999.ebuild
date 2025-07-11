# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="Cryptsetup wrapper to handle single passphrase on multiple LUKS devices"
HOMEPAGE="https://github.com/jakeogh/cryptsetup_open"
EGIT_REPO_URI="https://github.com/jakeogh/cryptsetup-open.git"

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

