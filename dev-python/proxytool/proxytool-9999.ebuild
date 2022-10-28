# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="common proxy functions"
HOMEPAGE="https://github.com/jakeogh/proxytool"
EGIT_REPO_URI="/home/cfg/_myapps/proxytool https://github.com/jakeogh/proxytool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/click-auto-help[${PYTHON_USEDEP}]
	net-vpn/corkscrew
"

DEPEND="${RDEPEND}"
