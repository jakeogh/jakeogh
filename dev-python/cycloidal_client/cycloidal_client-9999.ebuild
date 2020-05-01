# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1 git-r3

DESCRIPTION="Client software for cycloidal mass-spec"
HOMEPAGE="https://github.com/jakeogh/cycloidal_client"
EGIT_REPO_URI="/home/cfg/_myapps/cycloidal_client"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

#	dev-python/schedule[${PYTHON_USEDEP}]
RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/schedule[${PYTHON_USEDEP}]
	dev-python/wxpython:4.0[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
