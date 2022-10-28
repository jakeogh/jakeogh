# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/functiongenerator"
EGIT_REPO_URI="/home/cfg/_myapps/functiongenerator https://github.com/jakeogh/functiongenerator.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/uliengineering[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
