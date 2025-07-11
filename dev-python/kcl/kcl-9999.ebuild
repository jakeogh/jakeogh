# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools  # 6 for gentoo install

inherit distutils-r1
inherit git-r3

DESCRIPTION="Common function library"
HOMEPAGE="https://github.com/jakeogh/kcl"
EGIT_REPO_URI="https://github.com/jakeogh/kcl.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
"

python_install_all() {
	distutils-r1_python_install_all
}
