# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Common function library"
HOMEPAGE="https://github.com/jakeogh/kcl"
EGIT_REPO_URI="/home/cfg/_myapps/kcl https://github.com/jakeogh/kcl.git"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"

DEPEND="dev-python/psutil
dev-python/requests
dev-python/pydot
dev-db/sadisplay
dev-python/pycallgraph
dev-python/redis-py
dev-python/sqlalchemy-utils
sys-apps/file
"

#dev-python/python-magic # file has a python flag. will that work instead?


RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
