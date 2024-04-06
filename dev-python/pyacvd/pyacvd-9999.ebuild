# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="implementation of surface mesh resampling algorithm ACVD"
HOMEPAGE="https://github.com/pyvista/pyacvd"
EGIT_REPO_URI="https://github.com/pyvista/pyacvd.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
"

DEPEND="${RDEPEND}"
