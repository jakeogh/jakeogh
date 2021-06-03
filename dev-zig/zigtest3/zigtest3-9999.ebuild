# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3


DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/zigtest3"
EGIT_REPO_URI="/home/cfg/_myapps/zigtest3 https://github.com/jakeogh/zigtest3.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

DEPEND="dev-lang/zig"
