# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517="poetry"

inherit git-r3
inherit distutils-r1


DESCRIPTION="lightweight terminal spinner for Python with safe pipes and redirects"
HOMEPAGE="https://github.com/jakeogh/yaspin"
EGIT_REPO_URI="/home/sysskel/myapps/yaspin https://github.com/jakeogh/yaspin.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
