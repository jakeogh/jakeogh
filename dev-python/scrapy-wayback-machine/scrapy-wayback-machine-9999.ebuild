# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="wayback machine scaper"
HOMEPAGE="https://github.com/jakeogh/scrapy-wayback-machine"
EGIT_REPO_URI="/home/sysskel/myapps/scrapy-wayback-machine https://github.com/jakeogh/scrapy-wayback-machine.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/Scrapy[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

