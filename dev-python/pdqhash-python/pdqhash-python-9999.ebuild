# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 git-r3

DESCRIPTION="Python bindings for Facebook's PDQ hash"
HOMEPAGE="https://github.com/faustomorales/pdqhash-python"
EGIT_REPO_URI="https://github.com/faustomorales/pdqhash-python.git"
#EGIT_OVERRIDE_REPO_GIT_GITHUB_COM_FACEBOOK_THREATEXCHANGE="https://github.com/facebook/ThreatExchange.git"
EGIT_OVERRIDE_REPO_GIT_GITHUB_COM_FACEBOOK_THREATEXCHANGE="/home/user/_myapps/ThreatExchange"
EGIT_OVERRIDE_REPO_FACEBOOK_THREATEXCHANGE="/home/user/_myapps/ThreatExchange"

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
