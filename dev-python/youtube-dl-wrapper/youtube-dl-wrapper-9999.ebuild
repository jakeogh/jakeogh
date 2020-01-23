# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="wrapper for youtube-dl"
HOMEPAGE="https://github.com/jakeogh/youtube-dl-wrapper"
EGIT_REPO_URI="/home/cfg/_myapps/youtube-dl-wrapper https://github.com/jakeogh/youtube-dl-wrapper.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/sh
	net-misc/youtube-dl
	dev-db/redis
	x11-misc/xclip
	dev-python/click
	dev-python/smartmove
	dev-python/sh
	dev-python/kcl
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
