# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{11..13})

inherit git-r3
inherit distutils-r1

DESCRIPTION="A music and podcast downloader needing only Python and FFmpeg"
HOMEPAGE="https://gitlab.com/team-zotify/zotify"
EGIT_REPO_URI="https://gitlab.com/team-zotify/zotify.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/librespot-python[${PYTHON_USEDEP}]
	dev-python/ffmpy[${PYTHON_USEDEP}]
	dev-python/music-tag[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/pwinput[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
