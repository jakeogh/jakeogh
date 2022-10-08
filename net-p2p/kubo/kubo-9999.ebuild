# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3

inherit go-module golang-vcs golang-build
#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="IPFS implementation in Go"
HOMEPAGE="https://github.com/jakeogh/kubo"
EGIT_REPO_URI="/home/cfg/_myapps/kubo https://github.com/jakeogh/kubo.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}

src_install() {
        dobin ${app_name}
}