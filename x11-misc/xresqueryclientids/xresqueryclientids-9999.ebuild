# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3


#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="XResQueryClientIds example"
HOMEPAGE="https://github.com/jakeogh/xresqueryclientids"
EGIT_REPO_URI="/home/cfg/_myapps/xresqueryclientids https://github.com/jakeogh/xresqueryclientids.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}
