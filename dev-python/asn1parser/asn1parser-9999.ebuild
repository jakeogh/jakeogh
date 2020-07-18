# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1 git-r3

DESCRIPTION="Parse and extract data from ASN1"
HOMEPAGE="https://github.com/jakeogh/asn1parser"
EGIT_REPO_URI="/home/cfg/_myapps/asn1parser https://github.com/jakeogh/asn1parser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/asn1crypto[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
