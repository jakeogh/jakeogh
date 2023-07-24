# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="minimal global state for verbose"
HOMEPAGE="https://github.com/jakeogh/globalverbose"
EGIT_REPO_URI="/home/sysskel/myapps/globalverbose https://github.com/jakeogh/globalverbose.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND=""

DEPEND="${RDEPEND}"
