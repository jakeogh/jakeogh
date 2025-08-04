# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3

DESCRIPTION="Gerber X3/X2 standard with 2D rendering engine"
HOMEPAGE="https://github.com/Argmaster/pygerber"
EGIT_REPO_URI="https://github.com/Argmaster/pygerber.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}
