# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A Python library for working with atoms"
HOMEPAGE="https://gitlab.com/ase/ase"
EGIT_REPO_URI="https://gitlab.com/ase/ase.git"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="matplotlib scipy"

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		scipy? ( sci-libs/scipy[${PYTHON_USEDEP}] )
		matplotlib? ( dev-python/matplotlib[${PYTHON_USEDEP}] )
"

RDEPEND="${DEPEND}"
