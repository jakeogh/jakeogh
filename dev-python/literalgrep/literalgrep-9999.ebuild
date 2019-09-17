# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Replace text in file(s) or stdin."
HOMEPAGE="https://github.com/jakeogh/literalgrep"
EGIT_REPO_URI="/home/cfg/_myapps/literalgrep https://github.com/jakeogh/literalgrep.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""
LICENSE="MIT"

DEPEND="dev-python/click
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
