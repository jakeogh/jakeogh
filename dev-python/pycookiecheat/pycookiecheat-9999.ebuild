# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Borrow cookies from your browser's authenticated session for use in Python scripts."
HOMEPAGE="https://github.com/n8henrie/pycookiecheat"
EGIT_REPO_URI="https://github.com/n8henrie/pycookiecheat.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/keyring
		dev-python/pycrypto"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
