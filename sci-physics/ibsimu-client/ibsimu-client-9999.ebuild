# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3


#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="Client application for the Ion Beam Simulator ibsimu"
HOMEPAGE="https://github.com/dgasparri/IBSimu_Client"
EGIT_REPO_URI="https://github.com/dgasparri/IBSimu_Client.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


src_prepare() {
	mkdir bin/build -p
	echo "CWD: $CWD"
	default
#	xdg_src_prepare
}
