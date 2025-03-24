# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=(python3_{10..12})

inherit git-r3

#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="Easy rate-limiting for python requests"
HOMEPAGE="https://github.com/JWCook/requests-ratelimiter"
EGIT_REPO_URI="https://github.com/JWCook/requests-ratelimiter.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"
