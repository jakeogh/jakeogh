# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1

DESCRIPTION="Module for handling Internationalized Resource Identifiers (IRIs)."
HOMEPAGE="https://github.com/uogbuji/amara3-iri"
EGIT_REPO_URI="https://github.com/uogbuji/amara3-iri.git"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="Apache"

DEPEND="dev-python/setuptools"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
