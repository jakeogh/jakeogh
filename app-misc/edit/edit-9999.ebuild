# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )

#inherit distutils-r1
inherit git-r3

DESCRIPTION="bash version of vi wrapper for programatic(m) workflow"
HOMEPAGE="https://github.com/jakeogh/edit"
EGIT_REPO_URI="https://github.com/jakeogh/edit.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-util/splint
	dev-util/pkgcheck
	dev-util/pkgdev
	dev-python/pylint
	app-misc/commandlock
	dev-util/shellcheck
	sys-process/schedtool
	app-editors/neovim
	app-misc/newapp
	dev-python/isort
	dev-python/mypy
	dev-util/ctags
	dev-util/pkgdev
	dev-python/walkup-until-found
"
	#dev-python/memory_profiler
#	dev-util/diffuse[${PYTHON_USEDEP}]

src_install() {
#	dodoc README*
	#dobin ${PN}.sh
	newbin ${PN}.sh ${PN}_failsafe
	#dosym "/usr/bin/${PN}" "/usr/bin/${PN}f"
}
