# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#PYTHON_COMPAT=( python3_{8..9} )

inherit autotools git-r3

DESCRIPTION="free finite-difference time-domain (FDTD) software for electromagnetic simulations"
HOMEPAGE="https://github.com/NanoComp/meep"
EGIT_REPO_URI="/home/cfg/_myapps/meep https://github.com/NanoComp/meep.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
"

DEPEND="${RDEPEND}"

