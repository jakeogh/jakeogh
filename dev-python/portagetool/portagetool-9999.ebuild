# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

DESCRIPTION="Common portage operations"
HOMEPAGE="https://github.com/jakeogh/portagetool"
EGIT_REPO_URI="https://github.com/jakeogh/portagetool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/timetool[${PYTHON_USEDEP}]
	app-portage/gentoolkit[${PYTHON_USEDEP}]
	dev-python/mathtool[${PYTHON_USEDEP}]
	dev-python/clicktool[${PYTHON_USEDEP}]
	dev-python/run-command[${PYTHON_USEDEP}]
	dev-python/mptool[${PYTHON_USEDEP}]
	app-portage/portage-utils
"

DEPEND="${RDEPEND}"
