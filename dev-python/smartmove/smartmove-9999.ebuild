# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1 git-r3

DESCRIPTION="Move or delete files based on dest criteria."
HOMEPAGE="https://github.com/jakeogh/smartmove"
EGIT_REPO_URI="/home/cfg/_myapps/smartmove https://github.com/jakeogh/smartmove.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/kcl
dev-python/click
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
