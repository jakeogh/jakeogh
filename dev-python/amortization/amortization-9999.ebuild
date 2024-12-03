# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=poetry
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="library for calculating amortizations and generating amortization schedules"
HOMEPAGE="https://github.com/roniemartinez/amortization"
EGIT_REPO_URI="https://github.com/roniemartinez/amortization.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

#src_prepare() {
#	default
#	xdg_src_prepare
#}
