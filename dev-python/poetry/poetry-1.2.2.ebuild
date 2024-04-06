# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A frontend for poetry - a python dependency management and packaging tool"
HOMEPAGE="
	https://python-poetry.org/
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="filecache"
RESTRICT=""


RDEPEND="
	>=dev-python/poetry-core-1.3.2
	>=dev-python/poetry-plugin-export-1.1.2
	>=dev-python/cleo-1.0.0
	>=dev-python/crashtest-0.3.0
	>=dev-python/dulwich-0.20.46
	>=dev-python/filelock-3.8.0
	>=dev-python/html5lib-1.0
	>=dev-python/jsonschema-4.10.0
	>=dev-python/keyring-23.9.0
	>=dev-python/packaging-20.4
	>=dev-python/pexpect-4.7.0
	>=dev-python/pkginfo-1.5
	>=dev-python/platformdirs-2.5.2
	>=dev-python/requests-2.18
	>=dev-python/requests-toolbelt-0.9.1
	>=dev-python/shellingham-1.5.0
	>=dev-python/tomlkit-0.11.4
	>=dev-python/trove-classifiers-2022.5.19
	>=dev-python/virtualenv-20.4.7
	>=dev-python/urllib3-1.26.0

	filecache? (
		>=dev-python/cachecontrol-1.12.9
	)

"

if [[ "python3.8 python3.9" == *"${EPYTHON}"* ]]; then
	RDEPEND+="
		>=dev-python/importlib_metadata-4.4.0
	"
fi

