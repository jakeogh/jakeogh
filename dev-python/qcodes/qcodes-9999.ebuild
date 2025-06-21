# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1


DESCRIPTION="Modular data acquisition framework"
HOMEPAGE="https://github.com/jakeogh/qcodes"
EGIT_REPO_URI="https://github.com/jakeogh/qcodes.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/versioningit[${PYTHON_USEDEP}]
	dev-python/broadbean[${PYTHON_USEDEP}]
	dev-python/schema[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

distutils_enable_tests pytest
