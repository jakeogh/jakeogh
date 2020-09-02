# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Separate the TLD from the subdomains of a URL using the Public Suffix List."
HOMEPAGE="https://github.com/john-kurkowski/tldextract"
EGIT_REPO_URI="https://github.com/john-kurkowski/tldextract.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/requests-file[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	"

RDEPEND="${DEPEND}"

python_install_all() {
	local DOCS=( README.md )
	distutils-r1_python_install_all
}
