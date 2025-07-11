# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A Microsoft OneDrive client for Linux"
HOMEPAGE="https://github.com/xybu/onedrived-dev"
EGIT_REPO_URI="https://github.com/xybu/onedrived-dev"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"

DEPEND="
dev-python/dbus-python
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
