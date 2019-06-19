# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_7 )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Search zfs ids for specific parents"
HOMEPAGE="https://github.com/jakeogh/zfs-index"
EGIT_REPO_URI="/home/cfg/_myapps/zfs-index https://github.com/jakeogh/zfs-index.git"

LICENSE="Unlicense"
SLOT="0"
IUSE=""
KEYWORDS=""

DEPEND="
	dev-python/click
"

python_install_all() {
    distutils-r1_python_install_all
}
