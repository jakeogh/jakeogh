# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#PYTHON_COMPAT=( python3_{8..10} )

#inherit distutils-r1
inherit git-r3
inherit autotools

DESCRIPTION="Fast and functional image viewer"
HOMEPAGE="https://github.com/linuxmint/xviewer"
EGIT_REPO_URI="/home/cfg/_myapps/xviewer https://github.com/linuxmint/xviewer.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

#RDEPEND="
#	dev-python/click[${PYTHON_USEDEP}]
#	dev-python/icecream[${PYTHON_USEDEP}]
#	dev-python/colorama[${PYTHON_USEDEP}]
#"

DEPEND="${RDEPEND}"

src_install() {
	dobin xviewer
}
