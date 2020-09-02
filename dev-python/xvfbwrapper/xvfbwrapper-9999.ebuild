# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{7..9} pypy )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Python wrapper for running a display inside X virtual framebuffer"
HOMEPAGE="https://github.com/cgoldberg/xvfbwrapper https://pypi.org/project/xvfbwrapper/"
EGIT_REPO_URI="https://github.com/cgoldberg/xvfbwrapper.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="x11-base/xorg-server[xvfb]"
DEPEND="${RDEPEND}
	test? ( $(python_gen_cond_dep 'dev-python/mock[${PYTHON_USEDEP}]' python2_7) )
"

python_test() {
	"${PYTHON}" -m unittest discover || die "Tests failed with ${EPYTHON}"
}
