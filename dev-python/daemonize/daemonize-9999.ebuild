# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Library for writing system daemons in Python"
HOMEPAGE="https://github.com/thesharp/daemonize"
EGIT_REPO_URI="https://github.com/thesharp/daemonize.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
