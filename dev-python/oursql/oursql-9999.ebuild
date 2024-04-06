# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="set of MySQL bindings for python with a focus on wrapping the MYSQL_STMT API to provide real parameterization and real server-side cursors"
HOMEPAGE="https://github.com/python-oursql/oursql"
EGIT_REPO_URI="https://github.com/python-oursql/oursql.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="BSD-3-Clause"

DEPEND="dev-db/mysql"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
