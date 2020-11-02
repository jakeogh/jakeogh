# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-multilib git-r3

DESCRIPTION="Cross-platform path library for C/C++"
HOMEPAGE="https://github.com/likle/cwalk"
EGIT_REPO_URI="/home/cfg/_myapps/cwalk https://github.com/likle/cwalk.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
"

DEPEND="${RDEPEND}"
