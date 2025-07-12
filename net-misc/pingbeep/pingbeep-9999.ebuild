# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3

DESCRIPTION="beeps on ICMP echo reply"
HOMEPAGE="https://github.com/jakeogh/pingbeep"
EGIT_REPO_URI="https://github.com/jakeogh/pingbeep.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

src_install() {
    dobin ${PN}
}
