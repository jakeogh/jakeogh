# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Python interface to the awesome mpv media player"
HOMEPAGE="https://github.com/jaseg/python-mpv"
EGIT_REPO_URI="https://github.com/jaseg/python-mpv"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"

DEPEND=" media-video/mpv
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
