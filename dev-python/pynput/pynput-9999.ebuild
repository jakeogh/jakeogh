# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1
inherit git-r3

DESCRIPTION="Sends virtual input commands"
HOMEPAGE="https://github.com/moses-palmer/pynput https://pypi.org/project/pynput"
EGIT_REPO_URI="https://github.com/moses-palmer/pynput"
RDEPEND="
	dev-python/evdev[${PYTHON_USEDEP}]
	dev-python/python-xlib[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
