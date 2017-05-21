# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Block DNS requests"
HOMEPAGE="https://github.com/jakeogh/dnsgate"
EGIT_REPO_URI="https://github.com/jakeogh/dnsgate.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/tldextract
	dev-python/click
"
RDEPEND="${DEPEND}"

python_install_all() {
        local DOCS=( README.md )
        distutils-r1_python_install_all
}

