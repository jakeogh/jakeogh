# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="binary-recordset instance for iio files"
HOMEPAGE="https://github.com/DentonGroup/iioparser"
EGIT_REPO_URI="https://github.com/DentonGroup/iioparser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/binary-recordset[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"


