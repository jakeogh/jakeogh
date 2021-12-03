# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1
inherit optfeature

DESCRIPTION="A pure python PyVISA backend"
HOMEPAGE="https://github.com/jakeogh/pyvisa-py"
EGIT_REPO_URI="/home/cfg/_myapps/pyvisa-py https://github.com/jakeogh/pyvisa-py.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	>=dev-python/PyVISA-1.11.0[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/importlib_metadata[${PYTHON_USEDEP}]' python3_7)
"

BDEPEND="test? ( dev-python/PyVISA-sim[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx_rtd_theme

pkg_postinst() {
	optfeature "interfacing with Serial instruments" dev-python/pyserial
	optfeature "interfacing with USB instruments" dev-python/pyusb
	optfeature "interfacing with GPIB instruments" sci-libs/linux-gpib dev-python/gpib-ctypes
}
