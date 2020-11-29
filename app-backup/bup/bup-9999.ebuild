# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit python-any-r1
inherit git-r3

DESCRIPTION="A highly efficient backup system based on the git packfile format"
HOMEPAGE="https://bup.github.io/ https://github.com/bup/bup"
#SRC_URI="https://github.com/bup/bup/archive/${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/bup/bup.git"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
#IUSE="+doc test web"
#REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	app-arch/par2cmdline
	dev-python/fuse-python[${PYTHON_USEDEP}]
	dev-python/pylibacl[${PYTHON_USEDEP}]
	dev-python/pyxattr[${PYTHON_USEDEP}]
	sys-libs/readline:0
	dev-vcs/git
"


# unresolved sandbox issues
RESTRICT="test"

PATCHES=( "${FILESDIR}"/sitedir.patch )

src_configure() {
	# only build/install docs if enabled
	export PANDOC=$(usex doc pandoc "")

	./configure || die
}

src_test() {
	emake test
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr DOCDIR="/usr/share/${PF}" \
		SITEDIR="$(python_get_sitedir)" install
	python_fix_shebang "${ED}"
	python_optimize "${ED}"
}
