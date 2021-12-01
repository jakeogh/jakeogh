# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="compile and install u-boot/p-boot"
HOMEPAGE="https://github.com/jakeogh/uboottool"
EGIT_REPO_URI="/home/cfg/_myapps/uboottool https://github.com/jakeogh/uboottool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/crossdevtool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"