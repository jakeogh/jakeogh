# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Block DNS requests via host lists."
HOMEPAGE="https://github.com/jakeogh/dnsgate"
EGIT_REPO_URI="/home/user/_myapps/dnsgate https://github.com/jakeogh/dnsgate.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/tldextract
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/urltool[${PYTHON_USEDEP}]
	dev-python/stringtool[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	local DOCS=( README.md )
	mkdir -p /var/cache/dnsgate/tldextract_cache
	chmod o+w /var/cache/dnsgate/tldextract_cache
	distutils-r1_python_install_all
}
