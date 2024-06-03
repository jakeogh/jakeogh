# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Group specific types from the 'file' comand"
HOMEPAGE="https://github.com/jakeogh/classify"
EGIT_REPO_URI="https://github.com/jakeogh/classify.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

#sys-apps/file -python is done in python-magic-9999.ebuild
# dev-python/python-magic[${PYTHON_USEDEP}]  # https://github.com/ahupp/python-magic
RDEPEND="
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/clicktool[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]
	media-gfx/gifsicle
"


DEPEND="${RDEPEND}"
