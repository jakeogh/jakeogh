# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 git-r3

DESCRIPTION="Install Gentoo Linux"
HOMEPAGE="https://github.com/jakeogh/sendgentoo"
EGIT_REPO_URI="/home/cfg/_myapps/sendgentoo https://github.com/jakeogh/sendgentoo.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""
LICENSE="MIT"

# parted likes dmidecode, should send a patch for the ebuild
# debianutils should provide ischroot: https://bugs.gentoo.org/698812
DEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/python-dmenu[${PYTHON_USEDEP}]
	sys-apps/debianutils
	sys-fs/cryptsetup
	sys-fs/dosfstools
	sys-block/parted
	sys-apps/dmidecode
	sys-apps/pv
	dev-python/kcl[${PYTHON_USEDEP}]
	dev-tcltk/expect
	dev-python/humanfriendly[${PYTHON_USEDEP}]
	sys-apps/debianutils
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
