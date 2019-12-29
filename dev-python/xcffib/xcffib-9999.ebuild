# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} pypy )

inherit distutils-r1 virtualx toolchain-funcs
inherit git-r3


DESCRIPTION="A drop in replacement for xpyb, an XCB python binding"
HOMEPAGE="https://github.com/tych0/xcffib"
EGIT_REPO_URI="https://github.com/tych0/xcffib.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

COMMON_DEPEND="x11-libs/libxcb"
RDEPEND="
	$(python_gen_cond_dep '>=dev-python/cffi-1.1:=[${PYTHON_USEDEP}]' 'python*')
	$(python_gen_cond_dep '>=virtual/pypy-2.6.0' pypy )
	dev-python/six[${PYTHON_USEDEP}]
	${COMMON_DEPEND}"
DEPEND="
	dev-haskell/cabal-install
	dev-python/setuptools[${PYTHON_USEDEP}]
	${COMMON_DEPEND}
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		x11-base/xorg-server[xvfb]
		x11-apps/xeyes
	)"

#PATCHES=( "${FILESDIR}"/${PN}-0.4.2-test-imports.patch )

python_prepare_all() {
	distutils-r1_python_prepare_all
#	mkdir "${S}"/xcffib
#	cp "${S}"/module/* "${S}"/xcffib
}

#src_configure() {
#	python_foreach_impl run_in_build_dir configure
#}

src_compile() {
	emake xcffib
	#python_foreach_impl run_in_build_dir emake xcffib
}


python_test() {
	virtx nosetests -d -v
}
