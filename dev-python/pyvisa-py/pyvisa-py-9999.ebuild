# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python{3_4,3_5,3_6,3_7} )

inherit distutils-r1 git-r3

DESCRIPTION="Python VISA bindings for GPIB, RS232, and USB instruments"
#HOMEPAGE="https://github.com/pyvisa/pyvisa-py"
#EGIT_REPO_URI="https://github.com/pyvisa/pyvisa-py.git"
HOMEPAGE="https://github.com/hgrecco/pyvisa-py"
EGIT_REPO_URI="https://github.com/hgrecco/pyvisa-py.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
	>=dev-python/pyvisa-9999[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"
