# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Accurately separate the TLD from the registered domain and subdomains of a URL, using the Public Suffix List."
HOMEPAGE="https://github.com/john-kurkowski/tldextract"
EGIT_REPO_URI="https://github.com/john-kurkowski/tldextract.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/requests-file
	"

RDEPEND="${DEPEND}"

python_install_all() {
	local DOCS=( README.md )
	distutils-r1_python_install_all
}
