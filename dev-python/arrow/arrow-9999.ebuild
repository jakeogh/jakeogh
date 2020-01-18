# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

DESCRIPTION="Better dates & times for Python"
HOMEPAGE="https://github.com/crsmithdev/arrow/"
EGIT_REPO_URI="https://github.com/crsmithdev/arrow.git"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"

DEPEND="dev-python/python-dateutil
dev-python/nose
dev-python/sphinx
dev-python/simplejson
dev-python/backports-functools-lru-cache
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
