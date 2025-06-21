# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12,13} )
PYTHON_REQ_USE="ssl(+),threads(+)"

inherit distutils-r1 flag-o-matic pypi

DESCRIPTION="Coroutine-based network library"
HOMEPAGE="https://www.gevent.org/ https://pypi.org/project/gevent/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~mips ppc ppc64 ~riscv ~s390 ~sparc x86 ~amd64-linux ~x86-linux ~x64-macos"
IUSE="doc examples"
RESTRICT="test"

DEPEND="
	>=dev-libs/libev-4.31:=
	dev-libs/libuv:=
	>=net-dns/c-ares-1.12:=
	>=dev-python/greenlet-3[${PYTHON_USEDEP}]
	>=dev-python/cython-3.0.8[${PYTHON_USEDEP}]
	>=dev-python/cffi-1.12.3[${PYTHON_USEDEP}]
"

distutils_enable_sphinx doc


python_prepare_all() {
	export GEVENTSETUP_EMBED="false"

	distutils-r1_python_prepare_all
}

python_configure_all() {
	append-flags -fno-strict-aliasing
}

python_test() {
	# Just in case.
	export GEVENTTEST_USE_RESOURCES=-network

	cd src/gevent/tests || die

	# Tests which need network but aren't marked as such
	echo "test__getaddrinfo_import.py" >> tests_that_dont_use_resolver.txt || die
	echo "test_socketqcqqrwns.py" >> tests_that_dont_use_resolver.txt || die

	# Test hangs (testPeek)
	echo "test_socket.py" >> tests_that_dont_use_resolver.txt || die

	# TODO: figure out how to make them work and not hang
	#GEVENT_RESOLVER=ares \
	#       "${EPYTHON}" -m gevent.tests \
	#       --verbose \
	#       -uall,-network \
	#       --config known_failures.py \
	#       --ignore tests_that_dont_use_resolver.txt || die
	GEVENT_RESOLVER=dnspython \
		"${EPYTHON}" -m gevent.tests \
		--verbose \
		-uall,-network \
		--config known_failures.py \
		--ignore tests_that_dont_use_resolver.txt || die
	GEVENT_RESOLVER=thread \
		"${EPYTHON}" -m gevent.tests \
		--verbose \
		-uall,-network \
		--config known_failures.py \
		--ignore tests_that_dont_use_resolver.txt || die
	GEVENT_FILE=thread \
		"${EPYTHON}" -m gevent.tests \
		--verbose \
		-uall,-network \
		--config known_failures.py \
		test__*subprocess*.py || die
}

python_install_all() {
	local DOCS=( AUTHORS README.rst )
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
