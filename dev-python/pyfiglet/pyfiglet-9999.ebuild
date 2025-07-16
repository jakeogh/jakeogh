# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3

DESCRIPTION="Pure-python FIGlet implementation"
HOMEPAGE="
    https://pypi.org/project/pyfiglet/
    https://github.com/pwaller/pyfiglet
"
EGIT_REPO_URI="https://github.com/pwaller/pyfiglet.git"

LICENSE="MIT BSD HPND MIT NTP contrib? ( all-rights-reserved )"
SLOT="0"
IUSE="contrib"

# Live ebuilds should not have KEYWORDS
#KEYWORDS="~amd64"

# PATCHES assume release tarballs; disable for live
#PATCHES=( "${FILESDIR}/${P}-fix-test.patch" )

distutils_enable_tests pytest

src_prepare() {
    mv pyfiglet/fonts-standard pyfiglet/fonts || die
    if use contrib; then
        mv pyfiglet/fonts-contrib/* pyfiglet/fonts || die
    fi
    distutils-r1_src_prepare
}

