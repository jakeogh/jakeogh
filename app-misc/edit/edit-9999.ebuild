# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="vi wrapper for workflow"
HOMEPAGE="https://github.com/jakeogh"
EGIT_REPO_URI="/home/cfg/_myapps/edit"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="dev-util/splint
	app-portage/repoman
	dev-util/shellcheck
	dev-python/pylint[${PYTHON_USEDEP}]
	app-misc/commandlock
	app-editors/neovim
	app-misc/newapp[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/isort[${PYTHON_USEDEP}]
	dev-python/python-ctags[${PYTHON_USEDEP}]
	dev-python/mypy[${PYTHON_USEDEP}]
	dev-util/ctags
	dev-python/memory_profiler
"

RDEPEND="${DEPEND}"


src_install() {
#	dodoc README*
	dobin ${PN}
	dosym "/usr/bin/${PN}" "/usr/bin/${PN}f"
#	dobin ${PN}_test
}
