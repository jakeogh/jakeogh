# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="Modular data acquisition framework"
HOMEPAGE="https://github.com/jakeogh/qcodes"
EGIT_REPO_URI="/home/cfg/_myapps/qcodes https://github.com/jakeogh/qcodes.git"

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
