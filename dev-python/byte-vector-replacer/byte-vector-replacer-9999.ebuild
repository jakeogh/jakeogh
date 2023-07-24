# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="manages and applies dict of automatically replaced byte vectors in ~/.config"
HOMEPAGE="https://github.com/jakeogh/byte-vector-replacer"
EGIT_REPO_URI="/home/sysskel/myapps/byte-vector-replacer https://github.com/jakeogh/byte-vector-replacer.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/replace-text[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
