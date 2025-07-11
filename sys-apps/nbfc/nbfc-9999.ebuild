# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="NoteBook FanControl"
HOMEPAGE="https://github.com/hirschmann/nbfc"
EGIT_REPO_URI="https://github.com/hirschmann/nbfc.git"
EGIT_BRANCH="stable"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-lang/mono
"

DEPEND="${RDEPEND}"
#	test? ( dev-python/nose[${PYTHON_USEDEP}]
#		>=dev-python/toolz-0.8[${PYTHON_USEDEP}] )"

src_configure() {
	./build.sh
}
