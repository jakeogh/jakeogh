# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3


#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="make a unique string based on the current hardware"
HOMEPAGE="https://github.com/jakeogh/machinesignaturetool"
EGIT_REPO_URI="https://github.com/jakeogh/machinesignaturetool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}

src_install() {
    dobin ${PN}
}