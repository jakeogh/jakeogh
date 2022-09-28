# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Common interface for GPUB device control"
HOMEPAGE="https://github.com/jakeogh/gpibtool"
EGIT_REPO_URI="/home/cfg/_myapps/gpibtool https://github.com/jakeogh/gpibtool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/stdiotool[${PYTHON_USEDEP}]
	dev-python/bnftool[${PYTHON_USEDEP}]
	dev-python/PyVISA-py[${PYTHON_USEDEP}]
	dev-python/pymeasure[${PYTHON_USEDEP}]
	sci-libs/linux-gpib
	dev-python/PyVISA-sim[${PYTHON_USEDEP}]
"


DEPEND="${RDEPEND}"
