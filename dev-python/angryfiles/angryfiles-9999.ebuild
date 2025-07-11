# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="generate a tree of diverse file names"
HOMEPAGE="https://github.com/jakeogh/angryfiles"
EGIT_REPO_URI="https://github.com/jakeogh/angryfiles.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"

DEPEND="dev-python/click
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
