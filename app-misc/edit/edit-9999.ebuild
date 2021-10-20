# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="bash version of vi wrapper for programatic(m) workflow"
HOMEPAGE="https://github.com/jakeogh/edit"
EGIT_REPO_URI="/home/cfg/_myapps/edit https://github.com/jakeogh/edit.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-util/splint
	app-portage/repoman
	dev-python/pylint[${PYTHON_USEDEP}]
	app-misc/commandlock
	dev-util/shellcheck
	sys-process/schedtool
	app-editors/neovim
	app-misc/newapp[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/isort[${PYTHON_USEDEP}]
	dev-python/python-ctags[${PYTHON_USEDEP}]
	dev-python/mypy[${PYTHON_USEDEP}]
	dev-util/ctags
	dev-python/memory_profiler
	dev-util/pkgdev[${PYTHON_USEDEP}]
	dev-util/diffuse[${PYTHON_USEDEP}]
"

src_install() {
#	dodoc README*
	#dobin ${PN}.sh
	dobin ${PN}_failsafe ${PN}.sh
	#dosym "/usr/bin/${PN}" "/usr/bin/${PN}f"
	#dosym "/usr/bin/${PN}.sh" "/usr/bin/${PN}_failsafe"
#	dobin ${PN}_test
}
