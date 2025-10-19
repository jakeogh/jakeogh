# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="Parse and extract data from ASN1"
HOMEPAGE="https://github.com/jakeogh/asn1parser"
EGIT_REPO_URI="https://github.com/jakeogh/asn1parser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	
	dev-python/asn1crypto[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/python-asn1[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
