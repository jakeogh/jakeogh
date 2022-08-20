# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="python stock terminal"
HOMEPAGE="https://github.com/jakeogh/openbbterminal"
EGIT_REPO_URI="/home/cfg/_myapps/openbbterminal https://github.com/jakeogh/openbbterminal.git"
DISTUTILS_USE_SETUPTOOLS=pyproject.toml

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

BDEPEND="dev-python/pyproject2setuppy[${PYTHON_USEDEP}]"
#RDEPEND="dev-python/terminal[${PYTHON_USEDEP}]" # wrong pkx, terminal.py is in the repo
RDEPEND=""
DEPEND="${RDEPEND}"
