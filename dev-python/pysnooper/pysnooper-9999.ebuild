# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
PYPI_PN="PySnooper"
inherit distutils-r1
inherit git-r3

DESCRIPTION="Never use print for debugging again"
HOMEPAGE="
	https://pypi.org/project/pysnooper/
	https://github.com/cool-RR/PySnooper
"
EGIT_REPO_URI="https://github.com/cool-RR/PySnooper"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest
