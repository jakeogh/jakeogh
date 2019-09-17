# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="generate a tree of diverse file names"
HOMEPAGE="https://github.com/jakeogh/angryfiles"
EGIT_REPO_URI="https://github.com/jakeogh/angryfiles.git"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"

DEPEND="dev-python/click
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
