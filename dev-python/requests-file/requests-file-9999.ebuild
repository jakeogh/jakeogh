# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Transport adapter for fetching file:// URLs with the requests python library."
HOMEPAGE="https://github.com/dashea/requests-file"
EGIT_REPO_URI="https://github.com/dashea/requests-file"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

python_install_all() {
        local DOCS=( README.rst )
        distutils-r1_python_install_all
}

