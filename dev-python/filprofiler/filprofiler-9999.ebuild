# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 git-r3

DESCRIPTION="Python memory profiler for data processing"
HOMEPAGE="https://github.com/jakeogh/filprofiler"
EGIT_REPO_URI="/home/cfg/_myapps/filprofiler https://github.com/jakeogh/filprofiler.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
"

DEPEND="${RDEPEND}"

src_compile() {
	#mkdir -p "${WORKDIR}"/filprofiler-9999-python3_8/temp.linux-x86_64-3.8/filprofiler/target/release || die
	mkdir -p "${WORKDIR}"/filprofiler-9999/target/release || die
	distutils-r1_src_compile
	build_ext
	defaults
}
