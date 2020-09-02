# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Transforms tokens into original source code (while preserving whitespace)"
HOMEPAGE="https://github.com/myint/untokenize"
EGIT_REPO_URI="https://github.com/myint/untokenize.git"

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
