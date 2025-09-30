# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Python binding for curl-impersonate via cffi"
HOMEPAGE="https://github.com/yifeikong/curl_cffi"
EGIT_REPO_URI="https://github.com/yifeikong/curl_cffi.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
	>=dev-python/cffi-1.12.0[${PYTHON_USEDEP}]
	>=dev-python/certifi-2024.0.0[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove bundled curl-impersonate libraries if present
	rm -rf curl_cffi/.libs* 2>/dev/null || true

	distutils-r1_python_prepare_all
}

python_test() {
	# Skip tests that require network access
	epytest -m "not online" || die "Tests failed with ${EPYTHON}"
}

pkg_postinst() {
	elog "curl_cffi requires curl-impersonate libraries to function properly."
	elog "You may need to install curl-impersonate separately or use the"
	elog "bundled libraries that come with the Python package."
}
