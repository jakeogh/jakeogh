# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="build and deploy p-boot"
HOMEPAGE="https://github.com/jakeogh/pboottool"
EGIT_REPO_URI="https://github.com/jakeogh/pboottool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/crossdevtool[${PYTHON_USEDEP}]
	dev-util/ninja
"

DEPEND="${RDEPEND}"


#src_prepare() {
#	default
#	xdg_src_prepare
#}
