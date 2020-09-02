# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="GPG encrypting MDA"
HOMEPAGE="https://github.com/jakeogh/gpgmda"
EGIT_REPO_URI="https://github.com/jakeogh/gpgmda.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	app-shells/bash:*
	app-crypt/gnupg
	virtual/ssh
	app-arch/tar
	sys-apps/moreutils
	app-admin/sudo
"

RDEPEND="
	${DEPEND}
"

python_install_all() {
local DOCS=( README.md )
distutils-r1_python_install_all
}
