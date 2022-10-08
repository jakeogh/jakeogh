# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Python bindings for Facebook's PDQ hash"
HOMEPAGE="https://github.com/faustomorales/pdqhash-python"
EGIT_REPO_URI="/home/cfg/_myapps/pdqhash-python https://github.com/faustomorales/pdqhash-python.git"
EGIT_OVERRIDE_REPO_GIT_GITHUB_COM_FACEBOOK_THREATEXCHANGE="https://github.com/facebook/ThreatExchange.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

python_prepare_all() {
	rm -r "${WORKDIR}/${PN}-9999/tests" || die
	distutils-r1_python_prepare_all
}
