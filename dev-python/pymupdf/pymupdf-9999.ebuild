# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{10..12})

inherit git-r3
inherit distutils-r1

#inherit xdg
DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="library for data extraction, analysis, conversion & manipulation of documents"
HOMEPAGE="https://github.com/pymupdf/PyMuPDF"
EGIT_REPO_URI="https://github.com/pymupdf/PyMuPDF.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
"

DEPEND="${RDEPEND}"
