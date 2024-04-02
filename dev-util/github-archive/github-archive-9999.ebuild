# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1

#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="clone, pull, or fork user and org repos and gists to create a GitHub archive"
HOMEPAGE="https://github.com/Justintime50/github-archive"
EGIT_REPO_URI="/home/sysskel/myapps/github-archive https://github.com/Justintime50/github-archive.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"


src_prepare() {
	pwd
	/bin/ls -alh
	default
	#xdg_src_prepare
}
