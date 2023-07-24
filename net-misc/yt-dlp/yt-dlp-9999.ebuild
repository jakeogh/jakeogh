# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="youtube-dl fork"
HOMEPAGE="https://github.com/jakeogh/yt-dlp"
EGIT_REPO_URI="/home/sysskel/myapps/yt-dlp https://github.com/jakeogh/yt-dlp.git"
#EGIT_BRANCH="locked_file"
#EGIT_BRANCH="minicurses_bell"
#EGIT_BRANCH="continue_on_lock"
#EGIT_COMMIT="acea8d7cfb60d9f9c33ed7662f72110531a54e6d"

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
	sed -i -e 's/pycryptodomex/pycryptodome/g' requirements.txt || die
	distutils-r1_python_prepare_all
}
