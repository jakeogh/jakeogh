# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

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
DEPEND="dev-python/click[${PYTHON_USEDEP}]
sys-fs/cryptsetup
sys-fs/dosfstools
sys-block/parted
sys-apps/dmidecode
sys-apps/pv
dev-python/kcl[${PYTHON_USEDEP}]
dev-tcltk/expect
dev-python/humanfriendly[${PYTHON_USEDEP}]
"

# humanfriendly is blocking py3.7

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
