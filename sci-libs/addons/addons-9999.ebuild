# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="extra functionality for TensorFlow"
HOMEPAGE="https://github.com/jakeogh/addons"
EGIT_REPO_URI="/home/sysskel/myapps/addons https://github.com/jakeogh/addons.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/typeguard[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
