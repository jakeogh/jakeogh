# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

DESCRIPTION="Functions related to block devices"
HOMEPAGE="https://github.com/jakeogh/devicetool"
EGIT_REPO_URI="https://github.com/jakeogh/devicetool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/mounttool[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/warntool[${PYTHON_USEDEP}]
	dev-python/timetool[${PYTHON_USEDEP}]
	dev-python/timestamptool[${PYTHON_USEDEP}]
	dev-python/devicefilesystemtool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
