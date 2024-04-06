# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3


#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="solokey1"
HOMEPAGE="https://github.com/jakeogh/solo1"
EGIT_REPO_URI="/home/sysskel/myapps/solo1 https://github.com/jakeogh/solo1.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
