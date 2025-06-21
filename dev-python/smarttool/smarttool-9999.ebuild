# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1

#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="Device S.M.A.R.T. functions"
HOMEPAGE="https://github.com/jakeogh/smarttool"
EGIT_REPO_URI="https://github.com/jakeogh/smarttool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/clicktool[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/devicetool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
