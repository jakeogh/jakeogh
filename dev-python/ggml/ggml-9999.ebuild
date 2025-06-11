# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8


PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit cmake git-r3 distutils-r1

DESCRIPTION="Tensor library for machine learning, optimized for edge AI inference"
HOMEPAGE="https://github.com/ggml-org/ggml"
EGIT_REPO_URI="https://github.com/ggml-org/ggml.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="blas cuda opencl sycl hip"

DEPEND="
	blas? ( virtual/blas )
	cuda? ( dev-util/nvidia-cuda-toolkit )
	opencl? ( virtual/opencl )
	sycl? ( dev-libs/intel-oneapi-dpcpp )
	hip? ( dev-util/hip )
	${PYTHON_DEPS}
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	$(python_gen_cond_dep '
		dev-python/setuptools[${PYTHON_USEDEP}]
	')
"

src_prepare() {
	cmake_src_prepare
	distutils-r1_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGGML_BLAS=$(usex blas ON OFF)
		-DGGML_CUDA=$(usex cuda ON OFF)
		-DGGML_OPENCL=$(usex opencl ON OFF)
		-DGGML_SYCL=$(usex sycl ON OFF)
		-DGGML_HIP=$(usex hip ON OFF)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	distutils-r1_src_compile
}

src_install() {
	cmake_src_install
	distutils-r1_src_install
	dodoc README.md
}
