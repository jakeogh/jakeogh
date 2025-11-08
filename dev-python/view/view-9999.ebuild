# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="View a file, picking the approprate program"
HOMEPAGE="https://github.com/jakeogh/view"
EGIT_REPO_URI="https://github.com/jakeogh/view.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/classify[${PYTHON_USEDEP}]
	dev-python/hashfilter[${PYTHON_USEDEP}]
	net-misc/iridb[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/mpvpy[${PYTHON_USEDEP}]
	dev-python/hashfilter[${PYTHON_USEDEP}]
	www-client/elinks
	app-text/docx2txt
	app-text/antiword
	media-gfx/fbida
	media-libs/exiftool
	media-gfx/inkscape
	media-gfx/feh
	sys-fs/bindfs
"
#	kde-apps/okular  # depends on kde, and thus dbus
#	app-misc/ranger
#	app-text/djview

DEPEND="${RDEPEND}"
