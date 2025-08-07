EAPI=8

DISTUTILS_USE_PEP517=no
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 meson git-r3

DESCRIPTION="PyWavelets: Discrete Wavelet Transform in Python"
HOMEPAGE="https://github.com/PyWavelets/pywt"
EGIT_REPO_URI="https://github.com/PyWavelets/pywt.git"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
    >=dev-python/numpy-1.25[${PYTHON_USEDEP}]
"

BDEPEND="
    dev-python/meson-python[${PYTHON_USEDEP}]
    dev-python/cython[${PYTHON_USEDEP}]
    >=dev-python/numpy-2.0.0[${PYTHON_USEDEP}]
    test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

python_configure() {
    # You can pass additional meson options if needed
    meson_src_configure
}

python_compile() {
    meson_src_compile
}

python_test() {
    test? && meson_src_test
}

python_install() {
    meson_src_install
}
