# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="persistent pint unitregistry"
HOMEPAGE="https://github.com/jakeogh/unittool"
EGIT_REPO_URI="https://github.com/jakeogh/unittool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/configtool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

