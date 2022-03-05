# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="Unpack messagepacked objects and write to stdout without a delim"
HOMEPAGE="https://github.com/jakeogh/unmp"
EGIT_REPO_URI="/home/cfg/_myapps/unmp https://github.com/jakeogh/unmp.git"

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
