# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{7..9} pypy )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Easy VCS-based management of project version strings"
HOMEPAGE="https://pypi.org/project/versioneer/ https://github.com/warner/python-versioneer"
EGIT_REPO_URI="https://github.com/warner/python-versioneer.git"

SLOT="0"
LICENSE="public-domain"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	esetup.py make_versioneer
	git config --global user.email "you@example.com"
	git config --global user.name "Your Name"

	${PYTHON} test/git/test_git.py -v || die
}
