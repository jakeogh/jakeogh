# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1 autotools

DESCRIPTION="Future-aware personal finance application"
HOMEPAGE="https://github.com/hsoft/moneyguru"
EGIT_REPO_URI="https://github.com/hsoft/moneyguru"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"

DEPEND="dev-python/polib
"

RDEPEND="${DEPEND}"

#python_install_all() {
#	distutils-r1_python_install_all
#}
