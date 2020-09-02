# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1 git-r3

DESCRIPTION="pubchem search"
HOMEPAGE="https://github.com/jakeogh/pubchemmer"
EGIT_REPO_URI="/home/cfg/_myapps/pubchemmer https://github.com/jakeogh/pubchemmer.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	sci-chemistry/openbabel +python
"

DEPEND="${RDEPEND}"
