# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="clipster - python clipboard manager"
HOMEPAGE="https://github.com/mrichar1/clipster"
EGIT_REPO_URI="https://github.com/jakeogh/clipster.git" #has setup.py
inherit git-r3

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/pygobject:*
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
