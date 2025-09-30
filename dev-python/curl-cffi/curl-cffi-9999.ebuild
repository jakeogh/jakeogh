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
	net-misc/curl-impersonate
"
DEPEND="
	${RDEPEND}
"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${PN}-use-system-libs.patch"
)

distutils_enable_tests pytest

python_prepare_all() {
	# Point to system libcurl-impersonate instead of downloading
	export CURL_CFFI_USE_SYSTEM_LIBCURL=1
	export CURL_CFFI_LIBCURL_DIR="/usr/$(get_libdir)"

	distutils-r1_python_prepare_all
}

python_compile() {
	# Use system libcurl-impersonate
	export CURL_CFFI_USE_SYSTEM_LIBCURL=1
	export CURL_CFFI_LIBCURL_DIR="/usr/$(get_libdir)"

	distutils-r1_python_compile
}

python_test() {
	# Skip tests that require network access
	epytest -m "not online" || die "Tests failed with ${EPYTHON}"
}
