# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )
#PYTHON_COMPAT=( python3_4 )

inherit distutils-r1
inherit git-r3

DESCRIPTION="GPG encrypting MDA"
HOMEPAGE="https://github.com/jakeogh/gpgmda-client"
EGIT_REPO_URI="https://github.com/jakeogh/gpgmda-client.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	app-crypt/gpgme
	dev-python/pygpgme
	dev-python/configobj
	dev-python/python-magic
	dev-python/twisted
	dev-python/urwidtrees
	net-mail/notmuch
	www-client/lynx
	dev-python/pudb
	mail-client/alot
	mail-filter/afew
"

RDEPEND="
	${DEPEND}
"

python_install_all() {
local DOCS=( README.md )
dobin nottoomuch-addresses.sh
distutils-r1_python_install_all
}
