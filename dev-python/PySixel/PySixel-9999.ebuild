# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1
inherit toolchain-funcs
#inherit xdg

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/PySixel"
EGIT_REPO_URI="/home/cfg/_myapps/PySixel https://github.com/jakeogh/PySixel.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/python-imageloader[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"


src_prepare() {
	default
}

python_compile_all() {
	#tc-export CC
	emake
}

python_install_all() {
	distutils-r1_python_install_all
}
