# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Hash stdin"
HOMEPAGE="https://github.com/jakeogh/hashtool"
EGIT_REPO_URI="/home/cfg/_myapps/hashtool https://github.com/jakeogh/hashtool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/unmp[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/mptool[${PYTHON_USEDEP}]
	dev-python/advisory-lock[${PYTHON_USEDEP}]
	dev-python/python-getdents[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
