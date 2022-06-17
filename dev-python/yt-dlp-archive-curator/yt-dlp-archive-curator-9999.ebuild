# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/yt-dlp-archive-curator"
EGIT_REPO_URI="/home/cfg/_myapps/yt-dlp-archive-curator https://github.com/jakeogh/yt-dlp-archive-curator.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/pyppath[${PYTHON_USEDEP}]
	net-misc/iridb[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
