# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 git-r3

DESCRIPTION="genkernel/grub wrapper"
HOMEPAGE="https://github.com/jakeogh/compile-kernel"
EGIT_REPO_URI="/home/cfg/_myapps/compile-kernel https://github.com/jakeogh/compile-kernel.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/run-command[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/with-chdir[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

