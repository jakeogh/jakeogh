# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Simple yet powerful CAD (Computer Aided Design) library"
HOMEPAGE="https://github.com/jakeogh/pymadcad"
EGIT_REPO_URI="/home/cfg/_myapps/pymadcad https://github.com/jakeogh/pymadcad.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pyglm[${PYTHON_USEDEP}]
	dev-python/arrex[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
