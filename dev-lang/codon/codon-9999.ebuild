# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
CMAKE_MAKEFILE_GENERATOR=ninja
inherit git-r3 flag-o-matic fortran-2

DESCRIPTION="High-performance, zero-overhead, extensible Python compiler using LLVM"
HOMEPAGE="https://github.com/exaloop/codon"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
SLOT="0"
IUSE=""

RDEPEND="
	dev-libs/libfmt
	virtual/fortran
"
DEPEND="${RDEPEND}"
BDEPEND="dev-build/ninja"

RESTRICT="test"

CODON_LLVM_DIR="${WORKDIR}/llvm-project"
CPM_VERSION="0.40.8"

SRC_URI="
	https://github.com/cpm-cmake/CPM.cmake/releases/download/v${CPM_VERSION}/CPM.cmake -> CPM-${CPM_VERSION}.cmake
	https://github.com/exaloop/cpp-peglib/archive/codon.tar.gz -> cpp-peglib-codon.tar.gz
	https://github.com/fmtlib/fmt/archive/11.1.0.tar.gz -> fmt-11.1.0.tar.gz
	https://github.com/marzer/tomlplusplus/archive/v3.2.0.tar.gz -> tomlplusplus-3.2.0.tar.gz
	https://github.com/Neargye/semver/archive/v0.3.0.tar.gz -> semver-0.3.0.tar.gz
	https://github.com/zlib-ng/zlib-ng/archive/2.0.5.tar.gz -> zlib-ng-2.0.5.tar.gz
	https://github.com/xz-mirror/xz/archive/e7da44d5151e21f153925781ad29334ae0786101.tar.gz -> xz-5.2.5.tar.gz
	https://www.sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
	https://github.com/exaloop/bdwgc/archive/e16c67244aff26802203060422545d38305e0160.tar.gz -> bdwgc-8.0.5.tar.gz
	https://github.com/ianlancetaylor/libbacktrace/archive/d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a.tar.gz -> libbacktrace-d0f5e95.tar.gz
	https://github.com/google/re2/archive/5723bb8950318135ed9cf4fc76bed988a087f536.tar.gz -> re2-2022-06-01.tar.gz
	https://github.com/fastfloat/fast_float/archive/v6.1.1.tar.gz -> fast_float-6.1.1.tar.gz
	https://github.com/OpenMathLib/OpenBLAS/archive/v0.3.29.tar.gz -> OpenBLAS-0.3.29.tar.gz
	https://github.com/google/highway/archive/1.2.0.tar.gz -> highway-1.2.0.tar.gz
"

src_unpack() {
	EGIT_REPO_URI="https://github.com/exaloop/codon.git"
	EGIT_BRANCH="develop"
	EGIT_SUBMODULES=( '*' )
	EGIT_CHECKOUT_DIR="${S}"
	git-r3_src_unpack

	EGIT_REPO_URI="https://github.com/exaloop/llvm-project"
	EGIT_BRANCH="codon"
	EGIT_SUBMODULES=()
	EGIT_CHECKOUT_DIR="${CODON_LLVM_DIR}"
	git-r3_src_unpack

	mkdir -p "${S}/build/cmake" || die
	cp "${DISTDIR}/CPM-${CPM_VERSION}.cmake" "${S}/build/cmake/CPM_${CPM_VERSION}.cmake" || die

	mkdir -p "${WORKDIR}/cpm-cache" || die
	cd "${DISTDIR}" || die

	for archive in cpp-peglib-codon.tar.gz fmt-11.1.0.tar.gz tomlplusplus-3.2.0.tar.gz \
		semver-0.3.0.tar.gz zlib-ng-2.0.5.tar.gz xz-5.2.5.tar.gz bzip2-1.0.8.tar.gz \
		bdwgc-8.0.5.tar.gz libbacktrace-d0f5e95.tar.gz re2-2022-06-01.tar.gz \
		fast_float-6.1.1.tar.gz OpenBLAS-0.3.29.tar.gz highway-1.2.0.tar.gz; do
		tar -xf "${archive}" -C "${WORKDIR}/cpm-cache" || die
	done

	export CPM_SOURCE_CACHE="${WORKDIR}/cpm-cache"
	export CODON_SYSTEM_LIBRARIES="/usr/lib/gcc/x86_64-pc-linux-gnu/15/"

	filter-flags -mabm '--param=*'

	einfo "Building LLVM with clang and OpenMP..."
	cd "${WORKDIR}" || die
	cmake -S "${CODON_LLVM_DIR}/llvm" -B "${CODON_LLVM_DIR}/build" -G Ninja \
		-DCMAKE_BUILD_TYPE=Release \
		-DLLVM_INCLUDE_TESTS=OFF \
		-DLLVM_ENABLE_RTTI=ON \
		-DLLVM_ENABLE_ZLIB=OFF \
		-DLLVM_ENABLE_ZSTD=OFF \
		-DLLVM_ENABLE_TERMINFO=OFF \
		-DLLVM_ENABLE_PROJECTS="clang;openmp" \
		-DLLVM_TARGETS_TO_BUILD=all || die

	cmake --build "${CODON_LLVM_DIR}/build" || die
	cmake --install "${CODON_LLVM_DIR}/build" --prefix="${CODON_LLVM_DIR}/install" || die

	einfo "Configuring Codon..."
	cd "${S}" || die
	cmake -S . -B build -G Ninja \
		-DCMAKE_BUILD_TYPE=Release \
		-DLLVM_DIR="${CODON_LLVM_DIR}/install/lib/cmake/llvm" \
		-DCMAKE_C_COMPILER=clang \
		-DCMAKE_CXX_COMPILER=clang++ \
		-DCPM_SOURCE_CACHE="${WORKDIR}/cpm-cache" \
		-DCMAKE_SHARED_LINKER_FLAGS="-L/usr/lib/gcc/x86_64-pc-linux-gnu/15 -lgfortran" \
		-DCMAKE_EXE_LINKER_FLAGS="-L/usr/lib/gcc/x86_64-pc-linux-gnu/15 -lgfortran" || die

	einfo "Building Codon..."
	cmake --build build --config Release || die
}

src_configure() { :; }
src_compile() { :; }

src_install() {
	cd "${S}" || die
	DESTDIR="${D}" cmake --install build --prefix=/usr || die

	# Install OpenMP runtime from custom LLVM build
	insinto /usr/lib/codon
	doins "${CODON_LLVM_DIR}/install/lib/x86_64-unknown-linux-gnu"/libomp*.so*

	rm -rf "${ED}/usr/include/fmt" || die
	rm -rf "${ED}/usr/$(get_libdir)/cmake/fmt" || die
	rm -f "${ED}/usr/$(get_libdir)/pkgconfig/fmt.pc" || die
}
