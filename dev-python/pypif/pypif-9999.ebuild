# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Python toolkit for working with PIFs"
HOMEPAGE="https://github.com/CitrineInformatics/pypif"
EGIT_REPO_URI="https://github.com/CitrineInformatics/pypif.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/six"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
