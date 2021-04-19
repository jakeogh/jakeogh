# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 git-r3

DESCRIPTION="View a file, picking the approprate program"
HOMEPAGE="https://github.com/jakeogh/view"
EGIT_REPO_URI="/home/cfg/_myapps/view https://github.com/jakeogh/view.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/classify[${PYTHON_USEDEP}]
	net-misc/iridb[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	app-text/djview
	www-client/elinks
	app-text/docx2txt
	app-text/antiword
	media-gfx/fbida
	media-libs/exiftool
	media-gfx/inkscape
	app-misc/ranger
"

DEPEND="${RDEPEND}"
