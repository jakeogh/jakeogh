# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1 git-r3

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/structuredatafile"
EGIT_REPO_URI="/home/cfg/_myapps/structuredatafile https://github.com/jakeogh/structuredatafile.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	sci-chemistry/openbabel-python[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
