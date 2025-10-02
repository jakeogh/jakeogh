# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Estimates the number of records per pixel number"
HOMEPAGE="https://github.com/jakeogh/iio-pixel-record-count-estimator"
EGIT_REPO_URI="https://github.com/jakeogh/iio-pixel-record-count-estimator.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-lang/zig"
DEPEND="${RDEPEND}"
