# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="functions for parsing bytes"
HOMEPAGE="https://github.com/jakeogh/bytestool"
EGIT_REPO_URI="https://github.com/jakeogh/bytestool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/bitstring[${PYTHON_USEDEP}]
	dev-python/bitarray[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"


#src_prepare() {
#	default
#	xdg_src_prepare
#}
