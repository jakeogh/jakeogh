# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

EGIT_REPO_URI="https://github.com/lexiforest/curl_cffi"

DESCRIPTION="Python binding for curl-impersonate via cffi"
HOMEPAGE="https://github.com/yifeikong/curl_cffi"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=net-misc/curl-impersonate-0.6.0"
BDEPEND="dev-python/cffi"

PATCHES=(
	"${FILESDIR}/no-download_setup-0.7.patch"
)
