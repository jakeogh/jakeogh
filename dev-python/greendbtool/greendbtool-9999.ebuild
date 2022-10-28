# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Configuration manager for https://github.com/coleifer/greendb"
HOMEPAGE="https://github.com/jakeogh/greendbtool"
EGIT_REPO_URI="/home/cfg/_myapps/greendbtool https://github.com/jakeogh/greendbtool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/configtool[${PYTHON_USEDEP}]
	dev-python/retry-on-exception[${PYTHON_USEDEP}]
	app-misc/tmux
"

DEPEND="${RDEPEND}"
