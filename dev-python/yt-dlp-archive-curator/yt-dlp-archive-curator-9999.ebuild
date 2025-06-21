# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/yt-dlp-archive-curator"
EGIT_REPO_URI="https://github.com/jakeogh/yt-dlp-archive-curator.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/smartmove[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/pyppath[${PYTHON_USEDEP}]
	dev-python/jsontool[${PYTHON_USEDEP}]
	dev-python/yt-dlp-path-to-url-extractor[${PYTHON_USEDEP}]
	net-misc/iridb[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
