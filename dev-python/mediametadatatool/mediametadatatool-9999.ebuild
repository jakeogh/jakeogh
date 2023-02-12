# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="extract metadata from media"
HOMEPAGE="https://github.com/jakeogh/mediametadatatool"
EGIT_REPO_URI="/home/cfg/_myapps/mediametadatatool https://github.com/jakeogh/mediametadatatool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
	dev-python/classify[${PYTHON_USEDEP}]
	media-libs/libxmp[${PYTHON_USEDEP}]
	media-libs/exempi
"

DEPEND="${RDEPEND}"
