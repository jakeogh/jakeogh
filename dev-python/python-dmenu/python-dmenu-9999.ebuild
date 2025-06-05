# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="A python wrapper for dmenu."
HOMEPAGE="https://github.com/allonhadaya/dmenu-python"
EGIT_REPO_URI="https://github.com/allonhadaya/dmenu-python.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-misc/dmenu"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
