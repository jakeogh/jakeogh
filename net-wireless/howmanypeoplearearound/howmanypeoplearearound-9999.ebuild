# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="howmanypeoplearearound"
HOMEPAGE="https://github.com/schollz/howmanypeoplearearound"
EGIT_REPO_URI="https://github.com/schollz/howmanypeoplearearound.git"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"

DEPEND="dev-python/click
dev-python/netifaces
dev-python/pick
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
