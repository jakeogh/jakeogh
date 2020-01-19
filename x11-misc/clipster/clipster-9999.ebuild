# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

DESCRIPTION="clipster - python clipboard manager"
HOMEPAGE="https://github.com/mrichar1/clipster"
EGIT_REPO_URI="https://github.com/mrichar1/clipster.git" #has setup.py
#EGIT_REPO_URI="https://github.com/jakeogh/clipster.git" #has setup.py
inherit git-r3

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/pygobject:*
	dev-python/setuptools_scm
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
