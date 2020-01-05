# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="An FTP transport adapter for use with the Python Requests library."
HOMEPAGE="https://github.com/Lukasa/requests-ftp"
EGIT_REPO_URI="https://github.com/Lukasa/requests-ftp.git"
EGIT_SUBMODULES=()

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
