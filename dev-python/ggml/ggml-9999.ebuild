# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Tensor library for machine learning, optimized for edge AI inference"
HOMEPAGE="https://github.com/ggml-org/ggml"
EGIT_REPO_URI="https://github.com/ggml-org/ggml.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="blas cuda opencl sycl hip"

DEPEND="
	blas? ( sci-libs/openblas[openmp] )
	cuda? ( dev-util/nvidia-cuda-toolkit )
	opencl? ( virtual/opencl )
	sycl? ( dev-libs/intel-oneapi-dpcpp )
	hip? ( dev-util/hip )
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DGGML_BLAS=$(usex blas ON OFF)
		-DGGML_CUDA=$(usex cuda ON OFF)
		-DGGML_OPENCL=$(usex opencl ON OFF)
		-DGGML_SYCL=$(usex sycl ON OFF)
		-DGGML_HIP=$(usex hip ON OFF)
	)

	if use blas; then
		if ! pkg-config --libs openblas; then
			die "BLAS enabled but openblas not found. Please install sci-libs/openblas."
		fi
		local blas_cflags=$(pkg-config --cflags openblas)
		local blas_libs=$(pkg-config --libs openblas)
		mycmakeargs+=(
			-DGGML_BLAS_VENDOR=OpenBLAS
			-DCMAKE_C_FLAGS="${CFLAGS} ${blas_cflags}"
			-DCMAKE_CXX_FLAGS="${CXXFLAGS} ${blas_cflags}"
			-DCMAKE_SHARED_LINKER_FLAGS="${LDFLAGS} ${blas_libs}"
			-DBLAS_INCLUDE_DIRS="$(pkg-config --variable=includedir openblas)"
			-DBLAS_LIBRARIES="${blas_libs}"
		)
		einfo "BLAS CFLAGS: ${blas_cflags}"
		einfo "BLAS LIBS: ${blas_libs}"
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc README.md
}

