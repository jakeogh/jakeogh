# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
WX_GTK_VER="3.0"

PYTHON_COMPAT=( python3_{8..9} )

inherit cmake-utils desktop eutils toolchain-funcs wxwidgets git-r3 #distutils-r1

#DISTUTILS_USE_SETUPTOOLS=no

DESCRIPTION="Interconverts file formats used in molecular modeling"
HOMEPAGE="http://openbabel.org/wiki/Main_Page"
SRC_URI=""
EGIT_REPO_URI="https://github.com/openbabel/openbabel.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc java openmp perl python ruby test wxwidgets"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"


RDEPEND="
	dev-cpp/eigen:3
	sci-chemistry/maeparser
	dev-libs/rapidjson
	sci-mathematics/coordgenlibs
	dev-libs/libxml2:2
	sci-libs/inchi
	sys-libs/zlib
	wxwidgets? ( x11-libs/wxGTK:${WX_GTK_VER}[X] )
"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.8
	doc? ( app-doc/doxygen )
	python? ( >=dev-lang/swig-2 )"
PDEPEND=""

DOCS=( AUTHORS README.md THANKS doc/dioxin.{inc,mol2} doc/README.{dioxin.pov,povray} )

pkg_setup() {
	if use openmp; then
		if [[ $(tc-getCC) == *gcc ]] && ! tc-has-openmp; then
			ewarn "OpenMP is not available in your current selected gcc"
			die "need openmp capable gcc"
		fi
		FORTRAN_NEED_OPENMP=1
	fi
}

src_prepare() {
	cmake-utils_src_prepare
# using -DRUN_SWIG=ON below instead?
#	sed \
#		-e "s:\"\.\.\":\"${EPREFIX}/usr\":g" \
#		-i test/testbabel.py || die
#	swig -python -c++ -small -O -templatereduce -naturalvar \
#		-I"${EPREFIX}/usr/include/openbabel3" \
#		-o scripts/python/openbabel-python.cpp \
#		-DHAVE_EIGEN \
#		-outdir scripts/python \
#		scripts/openbabel-python.i \
#		|| die "Regeneration of openbabel-python.cpp failed"
}

src_configure() {
	use wxwidgets && setup-wxwidgets
	local mycmakeargs=(
		-DOPENBABEL_USE_SYSTEM_INCHI=ON
		-DENABLE_OPENMP=$(usex openmp)
		-DBUILD_GUI=$(usex wxwidgets)
		-DRUN_SWIG=ON
		-DPYTHON_BINDINGS=$(usex python)
	)

	cmake-utils_src_configure
}

src_install() {
	docinto html
	dodoc doc/{*.html,*.png}
	if use doc ; then
		docinto html/API
		dodoc -r doc/API/html/*
	fi

	make_desktop_entry obgui "Open Babel" "${PN}"
	#doicon "${DISTDIR}/${PN}.png"

	cmake-utils_src_install
}

src_test() {
	local mycmakeargs=(
		-DOPENBABEL_USE_SYSTEM_INCHI=ON
		-DPYTHON_EXECUTABLE=false
		-DOPENMP=$(usex openmp)
		-DBUILD_GUI=$(usex wxwidgets)
		-DTESTS=$(usex test)
	)

	cmake-utils_src_configure
	cmake-utils_src_compile
	cmake-utils_src_test -E py
}

pkg_postinst() {
	optfeature "python support" sci-chemistry/openbabel-python
}
