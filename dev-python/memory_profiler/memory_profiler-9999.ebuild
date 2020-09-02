# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 git-r3

DESCRIPTION="A module for monitoring memory usage of a python program"
HOMEPAGE="https://pypi.org/project/memory_profiler/ https://github.com/fabianp/memory_profiler"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
EGIT_REPO_URI="/home/cfg/_myapps/memory_profiler"
EGIT_BRANCH="asyncio"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

# dev-lang/mercury: collision on 'mprof'
# https://bugs.gentoo.org/571176
RDEPEND="
	dev-python/psutil[${PYTHON_USEDEP}]
	!dev-lang/mercury
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	${EPYTHON} -m memory_profiler test/test_func.py || die
	${EPYTHON} -m memory_profiler test/test_loop.py || die
	${EPYTHON} -m memory_profiler test/test_as.py || die
	${EPYTHON} -m memory_profiler test/test_global.py || die
	${EPYTHON} -m memory_profiler test/test_precision_command_line.py || die
	${EPYTHON} -m memory_profiler test/test_gen.py || die
	if python_is_python3; then
		${EPYTHON} -m memory_profiler test/test_unicode.py || die
	fi
	${EPYTHON} test/test_tracemalloc.py || die
	${EPYTHON} test/test_import.py || die
	${EPYTHON} test/test_memory_usage.py || die
	${EPYTHON} test/test_precision_import.py || die
}
