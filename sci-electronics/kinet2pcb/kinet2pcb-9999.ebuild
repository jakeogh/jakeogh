# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Utility to convert a KiCad netlist into a PCBNEW .kicad_pcb file"
HOMEPAGE="https://github.com/devbisme/kinet2pcb"
EGIT_REPO_URI="/home/sysskel/myapps/kinet2pcb https://github.com/devbisme/kinet2pcb.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
