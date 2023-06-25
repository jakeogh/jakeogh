# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1

DESCRIPTION="Programatically draw circuits"
HOMEPAGE="https://github.com/devbisme/skidl"
EGIT_REPO_URI="/home/cfg/_myapps/skidl https://github.com/devbisme/skidl"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	$(python_gen_cond_dep 'sci-electronics/kinparse[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/graphviz[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/future[${PYTHON_USEDEP}]')
	sci-electronics/kicad[${PYTHON_SINGLE_USEDEP}]
"

DEPEND="${RDEPEND}"

