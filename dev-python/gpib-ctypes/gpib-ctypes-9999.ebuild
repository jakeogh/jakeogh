# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python{3_4,3_5,3_6,3_7} )

inherit distutils-r1 git-r3

DESCRIPTION="Cross-platform Python bindings for the NI GPIB and linux-gpib C interfaces."
HOMEPAGE="https://github.com/dirkenstein/gpib_ctypes"
EGIT_REPO_URI="https://github.com/dirkenstein/gpib_ctypes.git"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS=""

RDEPEND=""

DEPEND="${RDEPEND}"

