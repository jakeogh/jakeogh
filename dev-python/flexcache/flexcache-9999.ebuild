# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="cache on disk the result of expensive calculations"
HOMEPAGE="https://github.com/hgrecco/flexcache"
EGIT_REPO_URI="https://github.com/hgrecco/flexcache.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND=""

DEPEND="${RDEPEND}"
