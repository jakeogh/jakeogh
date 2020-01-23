# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="a little task queue for python"
HOMEPAGE="https://github.com/coleifer/huey"
EGIT_REPO_URI="https://github.com/coleifer/huey.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""
LICENSE="MIT"

DEPEND="dev-python/redis-py
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
