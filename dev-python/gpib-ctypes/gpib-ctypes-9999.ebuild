# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

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

