# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit meson python-any-r1 git-r3

DESCRIPTION="Reference implementation of the ZIM specification"
HOMEPAGE="https://openzim.org/ https://github.com/openzim/libzim"
EGIT_REPO_URI="https://github.com/openzim/libzim.git"

LICENSE="GPL-2"
SLOT="0/9"
KEYWORDS=""
IUSE="doc test xapian"

RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/xz-utils
	app-arch/zstd:=
	dev-libs/icu:=
	xapian? ( dev-libs/xapian:= )
"

DEPEND="${RDEPEND}"

BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
	doc? (
		app-text/doxygen
		dev-python/sphinx
		dev-python/sphinx-rtd-theme
		dev-python/breathe
		dev-python/exhale
	)
	test? ( dev-cpp/gtest )
"

src_configure() {
	local emesonargs=(
		$(meson_use doc)
		$(meson_use xapian with_xapian)
		-Dwerror=false
	)

	if use test; then
		emesonargs+=( -Dtest_data_dir="${T}/test_data" )
	else
		emesonargs+=( -Dtest_data_dir=none )
	fi

	meson_src_configure
}

src_compile() {
	meson_src_compile

	if use doc; then
		meson_src_compile doc
	fi
}

src_test() {
	# Download test data if needed
	"${BUILD_DIR}"/scripts/download_test_data.py "${T}/test_data" || die "Failed to download test data"

	# Some tests need significant memory
	SKIP_BIG_MEMORY_TEST=1 meson_src_test
}

