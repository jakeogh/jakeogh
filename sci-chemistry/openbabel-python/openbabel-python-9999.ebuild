# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )

inherit cmake eutils git-r3 multilib distutils-r1 python-r1

DESCRIPTION="Python bindings for OpenBabel (including Pybel)"
HOMEPAGE="http://openbabel.sourceforge.net/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/openbabel/openbabel.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	~sci-chemistry/openbabel-${PV}
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=dev-lang/swig-2"

src_prepare() {
	cmake-utils_src_prepare
	sed \
		-e "s:\"\.\.\":\"${EPREFIX}/usr\":g" \
		-i test/testbabel.py || die
	swig -python -c++ -small -O -templatereduce -naturalvar \
		-I"${EPREFIX}/usr/include/openbabel3" \
		-o scripts/python/openbabel-python.cpp \
		-DHAVE_EIGEN \
		-outdir scripts/python \
		scripts/openbabel-python.i \
		|| die "Regeneration of openbabel-python.cpp failed"
}

src_configure() {
	my_impl_src_configure() {
		local mycmakeargs=(
			-DCMAKE_INSTALL_RPATH=
			-DOPTIMIZE_NATIVE=OFF
			-DBINDINGS_ONLY=ON
			-DBABEL_SYSTEM_LIBRARY="${EPREFIX}/usr/$(get_libdir)/libopenbabel.so"
			-DOB_MODULE_PATH="${EPREFIX}/usr/$(get_libdir)/openbabel/${PV}"
			-DPYTHON_BINDINGS=ON
			-DPYTHON_EXECUTABLE=${PYTHON}
			-DCMAKE_INSTALL_PREFIX="${D}/usr"
			-DPYTHON_INCLUDE_DIR="$(python_get_includedir)"
			-DPYTHON_INCLUDE_PATH="$(python_get_includedir)"
			-DPYTHON_LIBRARY="$(python_get_library_path)"
			-DENABLE_TESTS=ON
		)

		cmake-utils_src_configure
	}

	python_foreach_impl my_impl_src_configure
}

# likely bug, the python bindings are in the main openbable repo, op this ebuild shluld be converted to a sci-chemistry/openbabel USE flag
src_compile() {
	python_foreach_impl cmake-utils_src_make _openbabel
}

src_test() {
	python_foreach_impl cmake-utils_src_test -R py
}

src_install() {
	my_impl_src_install() {
		cd "${BUILD_DIR}" || die

		cmake -DCOMPONENT=bindings_python -P cmake_install.cmake || die

		python_optimize
	}

	python_foreach_impl my_impl_src_install
}
