# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# from https://github.com/flacjacket/gentoo-overlay/blob/master/dev-python/xcffib/xcffib-0.9.0.ebuild


EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7,8} pypy pypy3 )
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal distutils-r1

DESCRIPTION="A drop-in replacement for xpyb based on cffi"
HOMEPAGE="https://github.com/tych0/xcffib"
SRC_URI="https://github.com/tych0/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-haskell/attoparsec:=[profile?]
	dev-haskell/either:=[profile?]
	dev-haskell/filemanip:=[profile?]
	>=dev-haskell/language-python-0.5.6:=[profile?]
	>=dev-haskell/mtl-2.1:=[profile?]
	>=dev-haskell/optparse-applicative-0.13:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/split:=[profile?]
	>=dev-haskell/xcb-types-0.10.0:=[profile?]
	>=dev-lang/ghc-7.6.1:=
	dev-python/six[${PYTHON_USEDEP}]
	>=dev-python/cffi-1.1.0:=[$(python_gen_usedep 'python*')]
	x11-base/xcb-proto
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.16.0
	test? (
		dev-haskell/hunit
		dev-haskell/test-framework
		dev-haskell/test-framework-hunit
		dev-python/nose[${PYTHON_USEDEP}]
	)
"

src_prepare() {
	cabal-mksetup

	epatch "${FILESDIR}"/${PN}-nocabal.patch
	eapply_user
}

src_configure() {
	haskell-cabal_src_configure
}

src_compile() {
	# first, we have to build the generator
	haskell-cabal_src_compile

	# now, we can prepare, configure, and compile the python module
	distutils-r1_src_prepare
	distutils-r1_src_configure
	distutils-r1_src_compile
}

src_install() {
	haskell-cabal_src_install
	distutils-r1_src_install

	einstalldocs
}

python_prepare_all() {
	emake xcffib ver=${PV}

	distutils-r1_python_prepare_all
}
