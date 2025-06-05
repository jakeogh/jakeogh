# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="Pipe filter to pass unique items by hash tracking"
HOMEPAGE="https://github.com/jakeogh/uniquepipe"
EGIT_REPO_URI="https://github.com/jakeogh/uniquepipe.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/bitstring[${PYTHON_USEDEP}]
	dev-python/phashtool[${PYTHON_USEDEP}]
	dev-python/bitarray[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
