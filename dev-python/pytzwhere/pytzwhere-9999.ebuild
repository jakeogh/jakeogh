# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Offline timexone calculation"
HOMEPAGE="https://github.com/jakeogh/pytzwhere"
EGIT_REPO_URI="/home/cfg/_myapps/pytzwhere https://github.com/jakeogh/pytzwhere.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/shapely[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

