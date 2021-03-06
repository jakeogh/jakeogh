# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3

DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1


DESCRIPTION="Programatically draw circuits"
HOMEPAGE="https://github.com/jakeogh/skidl"
EGIT_REPO_URI="/home/cfg/_myapps/skidl https://github.com/jakeogh/skidl.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

# see https://dev.gentoo.org/~mgorny/python-guide/distutils.html#python-single-r1-variant
# kinparse is distutils-r1 (not sure if it should be...) => gen_cond_dep
# graphviz is distutils-r1 => gen_cond_dep
# kicad is python-single-r1 => just PYTHON_SINGLE_USEDEP
RDEPEND="
	$(python_gen_cond_dep 'sci-electronics/kinparse[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/graphviz[${PYTHON_USEDEP}]')
	sci-electronics/kicad[${PYTHON_SINGLE_USEDEP}]
"

DEPEND="${RDEPEND}"

#
#
#
#
#
#
## Copyright 1999-2021 Gentoo Authors
## Distributed under the terms of the GNU General Public License v2
#
#EAPI=7
#PYTHON_COMPAT=( python3_{8..10} )
#
#inherit git-r3
#
#DISTUTILS_SINGLE_IMPL=1
#inherit distutils-r1
#
#
#DESCRIPTION="Programatically draw circuits"
#HOMEPAGE="https://github.com/jakeogh/skidl"
#EGIT_REPO_URI="/home/cfg/_myapps/skidl https://github.com/jakeogh/skidl.git"
#
#LICENSE="BSD"
#SLOT="0"
#KEYWORDS=""
#
#
#RDEPEND="
#	$(python_gen_cond_dep '
#		sci-electronics/kinparse[${PYTHON_SINGLE_USEDEP}]
#		dev-python/graphviz[${PYTHON_SINGLE_USEDEP}]
#		sci-electronics/kicad[${PYTHON_SINGLE_USEDEP}]')
#"
#
#DEPEND="${RDEPEND}"
