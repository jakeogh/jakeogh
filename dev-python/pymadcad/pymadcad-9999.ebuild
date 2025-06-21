# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

DESCRIPTION="Simple yet powerful CAD (Computer Aided Design) library"
HOMEPAGE="https://github.com/jimy-byerley/pymadcad"
EGIT_REPO_URI="/home/sysskel/myapps/pymadcad https://github.com/jimy-byerley/pymadcad.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/pyglm[${PYTHON_USEDEP}]
	dev-python/arrex[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
