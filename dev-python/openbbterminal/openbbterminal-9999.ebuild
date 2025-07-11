# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="python stock terminal"
HOMEPAGE="https://github.com/jakeogh/openbbterminal"
EGIT_REPO_URI="/home/sysskel/myapps/openbbterminal https://github.com/jakeogh/openbbterminal.git"
DISTUTILS_USE_SETUPTOOLS=pyproject.toml

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

BDEPEND="dev-python/pyproject2setuppy[${PYTHON_USEDEP}]"
RDEPEND=""
DEPEND="${RDEPEND}"
