# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Python interface to posix_fadvise(2)"
HOMEPAGE="http://chris-lamb.co.uk/projects/python-fadvise/"
EGIT_REPO_URI="https://github.com/lamby/python-fadvise.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
