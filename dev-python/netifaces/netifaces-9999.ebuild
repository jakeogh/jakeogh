# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Portable network interface information"
HOMEPAGE="
	https://pypi.org/project/netifaces/
	https://alastairs-place.net/projects/netifaces/
	https://github.com/al45tair/netifaces
"
EGIT_REPO_URI="https://github.com/al45tair/netifaces.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}"/${PN}-0.10.4-remove-osx-fix.patch )
