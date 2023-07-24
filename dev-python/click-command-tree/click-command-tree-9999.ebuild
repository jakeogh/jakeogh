# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/whwright/click-command-tree"
EGIT_REPO_URI="/home/sysskel/myapps/click_command_tree https://github.com/whwright/click-command-tree.git"
EGIT_BRANCH="fixes"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/click-plugins[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

