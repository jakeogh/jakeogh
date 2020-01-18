# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Reference implementation in python for Citrination api"
HOMEPAGE="https://github.com/CitrineInformatics/python-citrination-client"
EGIT_REPO_URI="https://github.com/CitrineInformatics/python-citrination-client.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""
LICENSE="Apache-2.0"

DEPEND="dev-python/requests
	dev-python/pypif
	dev-python/six"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
