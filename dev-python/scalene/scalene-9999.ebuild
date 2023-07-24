# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="high-performance, high-precision CPU, GPU, and memory profiler"
HOMEPAGE="https://github.com/jakeogh/scalene"
EGIT_REPO_URI="/home/sysskel/myapps/scalene https://github.com/jakeogh/scalene.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
"

#	dev-python/heap-layers[${PYTHON_USEDEP}]
DEPEND="${RDEPEND}"
