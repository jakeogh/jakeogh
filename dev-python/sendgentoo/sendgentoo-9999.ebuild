# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

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
RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/python-dmenu[${PYTHON_USEDEP}]
	sys-apps/debianutils
	sys-fs/cryptsetup
	sys-fs/dosfstools
	sys-block/parted
	sys-apps/gptfdisk
	sys-apps/openrc
	sys-apps/dmidecode
	dev-python/humanfriendly[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	dev-python/compile_kernel[${PYTHON_USEDEP}]
	sys-apps/pv
	dev-python/kcl[${PYTHON_USEDEP}]
	dev-python/retry_on_exception[${PYTHON_USEDEP}]
	dev-tcltk/expect
	dev-python/humanfriendly[${PYTHON_USEDEP}]
	sys-apps/debianutils
	dev-python/pexpect[${PYTHON_USEDEP}]
"

python_install_all() {
	distutils-r1_python_install_all
}
