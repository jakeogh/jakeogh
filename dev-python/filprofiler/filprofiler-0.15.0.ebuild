# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

CRATES=""

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="/home/cfg/_myapps/py_spy https://github.com/benfred/py-spy.git"
	inherit git-r3
else
	SRC_URI="
			https://github.com/pythonspeed/filprofiler/archive/${PV}.tar.gz -> ${P}.tar.gz
			$(cargo_crate_uris ${CRATES})
			"
	KEYWORDS="~amd64 ~arm64 ~ppc64"
fi

inherit cargo distutils-r1

DESCRIPTION="Python memory profiler for data processing"
HOMEPAGE="https://github.com/jakeogh/filprofiler"
EGIT_REPO_URI="https://github.com/jakeogh/filprofiler.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/threadpoolctl
"

DEPEND="${RDEPEND}"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		default
		cargo_src_unpack
	fi
}

src_compile() {
	cargo_src_compile
	distutils-r1_src_compile
}
