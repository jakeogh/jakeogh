# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Group specific types from the 'file' comand"
HOMEPAGE="https://github.com/jakeogh/classify"
EGIT_REPO_URI="/home/cfg/_myapps/classify https://github.com/jakeogh/classify.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/clicktool[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]  # https://github.com/ahupp/python-magic
	media-gfx/gifsicle
"

#sys-apps/file -python is done in python-magic-9999.ebuild

DEPEND="${RDEPEND}"
