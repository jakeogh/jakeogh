# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#PYTHON_COMPAT=( python3_{7,8} )

inherit git-r3 cmake-utils desktop eutils toolchain-funcs

DESCRIPTION="Parser for Schrodinger Maestro files"
HOMEPAGE="https://github.com/schrodinger/maeparser"
EGIT_REPO_URI="/home/cfg/_myapps/maeparser https://github.com/schrodinger/maeparser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
"

DEPEND="${RDEPEND}"
