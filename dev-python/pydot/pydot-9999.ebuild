# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Python interface to Graphviz's Dot language"
HOMEPAGE="https://pypi.python.org/pypi/pydot"
EGIT_REPO_URI="https://github.com/erocarrera/pydot"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="
	dev-python/pyparsing[${PYTHON_USEDEP}]
	media-gfx/graphviz"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

#PATCHES=(
#	"${FILESDIR}"/${PN}-1.0.23-setup.patch
#	"${FILESDIR}"/${P}-pyparsing2fix.patch )
