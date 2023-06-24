# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3

#DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1


DESCRIPTION="Programatically draw circuits"
HOMEPAGE="https://github.com/devbisme/skidl"
EGIT_REPO_URI="https://github.com/devbisme/skidl"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

# see https://dev.gentoo.org/~mgorny/python-guide/distutils.html#python-single-r1-variant
# kinparse is distutils-r1 (not sure if it should be...) => gen_cond_dep
# graphviz is distutils-r1 => gen_cond_dep
# kicad is python-single-r1 => just PYTHON_SINGLE_USEDEP

RDEPEND="
	sci-electronics/kinparse[${PYTHON_USEDEP}]
	dev-python/graphviz[${PYTHON_USEDEP}]
	sci-electronics/kicad[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

#RDEPEND="
#	$(python_gen_cond_dep 'sci-electronics/kinparse[${PYTHON_USEDEP}]')
#	$(python_gen_cond_dep 'dev-python/graphviz[${PYTHON_USEDEP}]')
#	sci-electronics/kicad[${PYTHON_SINGLE_USEDEP}]
#	dev-python/future[${PYTHON_SINGLE_USEDEP}]
#"
#
#DEPEND="${RDEPEND}"

