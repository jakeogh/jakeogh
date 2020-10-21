# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1
inherit git-r3


DESCRIPTION="Python Data Validation for Humans"
HOMEPAGE="https://github.com/kvesteri/validators"
EGIT_REPO_URI="/home/cfg/_myapps/validators https://github.com/kvesteri/validators.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
