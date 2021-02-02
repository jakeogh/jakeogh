# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="GPG encrypting MDA"
HOMEPAGE="https://github.com/jakeogh/gpgmda-client"
EGIT_REPO_URI="https://github.com/jakeogh/gpgmda-client.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-crypt/gpgme[${PYTHON_USEDEP}]
	dev-python/pygpgme[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/twisted[${PYTHON_USEDEP}]
	dev-python/urwidtrees[${PYTHON_USEDEP}]
	net-mail/notmuch[${PYTHON_USEDEP}]
	dev-python/pudb[${PYTHON_USEDEP}]
	mail-client/alot[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]
	sys-apps/moreutils
	www-client/lynx
"
#	sys-apps/file[python]
#	mail-filter/afew

python_install_all() {
local DOCS=( README.md )
	dobin nottoomuch-addresses.sh
	dobin gpgmda-client-make-alot-config.sh
	dobin gpgmda-client-make-alot-theme.sh
	dobin gpgmda-client-send.sh
	distutils-r1_python_install_all
}
