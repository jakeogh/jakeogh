# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="Python wrapper for mpv"
HOMEPAGE="https://github.com/jakeogh/mpvpy"
EGIT_REPO_URI="https://github.com/jakeogh/mpvpy.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/python-mpv[${PYTHON_USEDEP}]
	dev-python/hashfilter[${PYTHON_USEDEP}]
	dev-python/clipboardtool[${PYTHON_USEDEP}]
	dev-python/jsontool[${PYTHON_USEDEP}]
	dev-python/click-auto-help[${PYTHON_USEDEP}]
	dev-python/terminaltool[${PYTHON_USEDEP}]
	dev-python/pynput[${PYTHON_USEDEP}]
	sys-process/schedtool
	media-plugins/alsaequal
"
