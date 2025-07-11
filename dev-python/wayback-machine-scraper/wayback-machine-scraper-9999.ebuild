# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="wayback machine scaper"
HOMEPAGE="https://github.com/jakeogh/wayback-machine-scraper"
EGIT_REPO_URI="/home/sysskel/myapps/wayback-machine-scraper https://github.com/jakeogh/wayback-machine-scraper.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/scrapy-wayback-machine[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"


#src_prepare() {
#	default
#	xdg_src_prepare
#}
