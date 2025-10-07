# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="decode the gpio field from an iio file"
HOMEPAGE="https://github.com/jakeogh/iio-gpio-record-decoder"
EGIT_REPO_URI="https://github.com/jakeogh/iio-gpio-record-decoder.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND=""

DEPEND="${RDEPEND}"


