# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="A simple Python wrapper around inotify"
HOMEPAGE="https://github.com/chrisjbillington/inotify_simple"
EGIT_REPO_URI="https://github.com/chrisjbillington/inotify_simple.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
"

DEPEND="${RDEPEND}"
