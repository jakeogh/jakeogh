# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )
CRATES="
clap-2.33.3"


inherit distutils-r1 git-r3
inherit cargo

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/benfred/py-spy"
EGIT_REPO_URI="/home/cfg/_myapps/py_spy https://github.com/benfred/py-spy.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/click-command-tree[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

