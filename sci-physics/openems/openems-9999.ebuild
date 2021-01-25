# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 git-r3 cmake-utils

DESCRIPTION="Electromagnetic field solver using the FDTD method"
HOMEPAGE="https://github.com/thliebig/openEMS-Project"
EGIT_REPO_URI="/home/cfg/_myapps/openems https://github.com/thliebig/openEMS-Project.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
"

DEPEND="${RDEPEND}"

