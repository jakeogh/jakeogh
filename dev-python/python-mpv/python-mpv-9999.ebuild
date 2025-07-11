# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1
inherit git-r3

DESCRIPTION="Python interface to the awesome mpv media player"
HOMEPAGE="https://github.com/jaseg/python-mpv"
EGIT_REPO_URI="https://github.com/jaseg/python-mpv"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""
LICENSE="MIT"

DEPEND="
	media-video/mpv[libmpv]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
