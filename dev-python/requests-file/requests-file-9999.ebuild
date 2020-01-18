# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Transport adapter for fetching file:// URLs with the requests python library."
HOMEPAGE="https://github.com/dashea/requests-file"
EGIT_REPO_URI="https://github.com/dashea/requests-file.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

python_install_all() {
	local DOCS=( README.rst )
	distutils-r1_python_install_all
}
