# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Terminal string styling done right in Python"
HOMEPAGE="https://github.com/timofurrer/colorful"
EGIT_REPO_URI="https://github.com/timofurrer/colorful.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install
	find "${ED}" -name '*.pth' -delete || die
}
