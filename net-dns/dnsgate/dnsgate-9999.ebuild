# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Block DNS requests via host lists."
HOMEPAGE="https://github.com/jakeogh/dnsgate"
EGIT_REPO_URI="https://github.com/jakeogh/dnsgate.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/tldextract
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/urltool[${PYTHON_USEDEP}]
	dev-python/hashtool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/logtool[${PYTHON_USEDEP}]
	dev-python/stringtool[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	local DOCS=( README.md )
	distutils-r1_python_install_all
}
