# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3

DESCRIPTION="Cryptsetup wrapper to handle single passphrase on multiple LUKS devices"
HOMEPAGE="https://github.com/jakeogh/cryptsetup_open"
EGIT_REPO_URI="/home/cfg/_myapps/cryptsetup_open https://github.com/jakeogh/cryptsetup_open.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

