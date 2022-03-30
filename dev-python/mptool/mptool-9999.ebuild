# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1
#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="messagepack functions for typed CLI IPC"
HOMEPAGE="https://github.com/jakeogh/mptool"
EGIT_REPO_URI="/home/cfg/_myapps/mptool https://github.com/jakeogh/mptool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"


#src_prepare() {
#	default
#	xdg_src_prepare
#}
