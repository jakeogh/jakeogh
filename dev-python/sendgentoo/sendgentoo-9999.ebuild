# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Install Gentoo Linux"
HOMEPAGE="https://github.com/jakeogh/sendgentoo"
EGIT_REPO_URI="/home/cfg/_myapps/sendgentoo https://github.com/jakeogh/sendgentoo.git"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"

# parted likes dmidecode, should send a patch for the ebuild
DEPEND="dev-python/click
sys-fs/dosfstools
sys-block/parted
sys-apps/dmidecode
sys-apps/pv
dev-python/kcl
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
