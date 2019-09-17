# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1

DESCRIPTION="Transforms tokens into original source code (while preserving whitespace)"
HOMEPAGE="https://github.com/myint/untokenize"
EGIT_REPO_URI="https://github.com/myint/untokenize.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
