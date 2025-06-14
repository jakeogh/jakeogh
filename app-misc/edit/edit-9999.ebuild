# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools


inherit distutils-r1
inherit git-r3

DESCRIPTION="bash version of vi wrapper for programatic(m) workflow"
HOMEPAGE="https://github.com/jakeogh/edit"
EGIT_REPO_URI="https://github.com/jakeogh/edit.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-util/splint
	dev-util/pkgcheck[${PYTHON_USEDEP}]
	dev-util/pkgdev[${PYTHON_USEDEP}]
	dev-python/pylint[${PYTHON_USEDEP}]
	app-misc/commandlock
	dev-util/shellcheck
	sys-process/schedtool
	app-editors/neovim
	app-misc/newapp[${PYTHON_USEDEP}]
	dev-python/isort[${PYTHON_USEDEP}]
	dev-python/mypy[${PYTHON_USEDEP}]
	dev-util/ctags
	dev-util/pkgdev[${PYTHON_USEDEP}]
	dev-python/walkup-until-found[${PYTHON_USEDEP}]
"
	#dev-python/memory_profiler
#	dev-util/diffuse[${PYTHON_USEDEP}]

src_install() {
#	dodoc README*
	#dobin ${PN}.sh
	newbin ${PN}.sh ${PN}_failsafe
	#dosym "/usr/bin/${PN}" "/usr/bin/${PN}f"
}
