# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="Open source Spotify client"
HOMEPAGE="https://github.com/kokarare1212/librespot-python"
EGIT_REPO_URI="/home/sysskel/myapps/librespot-python https://github.com/kokarare1212/librespot-python.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
"

DEPEND="${RDEPEND}"

