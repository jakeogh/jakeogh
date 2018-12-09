# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Wrapper around the wx.ListCtrl that makes it easier to use"
HOMEPAGE="https://bitbucket.org/wbruhin/objectlistview"
EHG_REPO_URI="https://wbruhin@bitbucket.org/wbruhin/objectlistview"
inherit mercurial

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/wxpython
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
