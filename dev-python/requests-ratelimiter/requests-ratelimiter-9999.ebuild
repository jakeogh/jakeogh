# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{8..12})
DISTUTILS_USE_PEP517=poetry

inherit distutils-r1 git-r3

DESCRIPTION="Rate-limiting for the requests library"
HOMEPAGE="https://github.com/JWCook/requests-ratelimiter https://pypi.org/project/requests-ratelimiter/"
EGIT_REPO_URI="https://github.com/JWCook/requests-ratelimiter.git"

LICENSE="MIT"
SLOT="0"
# No KEYWORDS for live ebuilds

RDEPEND="
	>=dev-python/requests-2.20[${PYTHON_USEDEP}]
	=dev-python/pyrate-limiter-2.8.0[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	dev-python/poetry-core
	test? (
		>=dev-python/pytest-8.3[${PYTHON_USEDEP}]
		>=dev-python/requests-mock-1.11[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

## Copyright 1999-2025 Gentoo Authors
## Distributed under the terms of the GNU General Public License v2
#
#EAPI=8
#DISTUTILS_USE_PEP517=setuptools
#PYTHON_COMPAT=(python3_{10..12})
#
#inherit git-r3
#
##DISTUTILS_USE_SETUPTOOLS=pyproject.toml
#
#DESCRIPTION="Easy rate-limiting for python requests"
#HOMEPAGE="https://github.com/JWCook/requests-ratelimiter"
#EGIT_REPO_URI="https://github.com/JWCook/requests-ratelimiter.git"
#
#LICENSE="BSD"
#SLOT="0"
#KEYWORDS=""
#
#RDEPEND="
#	>=dev-python/requests-2.25[${PYTHON_USEDEP}]
#	>=dev-python/pyrate-limiter-2.8[${PYTHON_USEDEP}]
#"
##BDEPEND="
##	test? (
##		dev-python/pytest[${PYTHON_USEDEP}]
##		dev-python/pytest-httpserver[${PYTHON_USEDEP}]
##	)
##"
#
##distutils_enable_tests pytest
#
#src_prepare() {
#	default
#	# Remove coverage testing
#	sed -i '/--cov/d' pyproject.toml || die "sed failed"
#}
