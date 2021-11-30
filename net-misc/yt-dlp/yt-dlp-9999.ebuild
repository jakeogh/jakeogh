# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="youtube-dl fork"
HOMEPAGE="https://github.com/jakeogh/yt-dlp"
EGIT_REPO_URI="/home/cfg/_myapps/yt-dlp https://github.com/jakeogh/yt-dlp.git"
EGIT_BRANCH="locked_file"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/websockets[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

python_prepare_all() {
	sed -i -e 's/pycryptodomex/pycryptodome/g' setup.py || die
}
