# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Adjacency List Relationships helper (only using databases own implementations)"
HOMEPAGE="https://github.com/ovgu-ttz/sqla_hierarchy" # orig from https://github.com/marplatense/sqla_hierarchy
EGIT_REPO_URI="https://github.com/ovgu-ttz/sqla_hierarchy.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
dev-python/nose
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
