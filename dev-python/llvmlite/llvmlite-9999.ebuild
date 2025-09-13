# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# llvmlite uses setuptools (PEP 517 backend) and builds a C++ core via CMake/ninja.
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit git-r3 distutils-r1

DESCRIPTION="Lightweight LLVM Python binding used by Numba (live ebuild)"
HOMEPAGE="https://llvmlite.pydata.org/ https://github.com/numba/llvmlite"
EGIT_REPO_URI="https://github.com/numba/llvmlite.git"
EGIT_BRANCH="main"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""  # live
IUSE="test"

# Upstream pins: as of 0.45+, requires LLVM 20.x.x.
# We export LLVM_CONFIG pointing at slot 20.
# Build pulls in cmake/ninja via ffi/build.py.
BDEPEND="
	${PYTHON_DEPS}
	dev-build/cmake
	dev-build/ninja
"
# llvmlite links against LLVM; require slot 20 explicitly.
DEPEND="
	sys-devel/llvm:20
"
RDEPEND="
	${DEPEND}
"

RESTRICT="!test? ( test )"

# If upstream adds/changes src layout, distutils-r1 will still handle it.

# Helper to ensure we always use the right llvm-config for slot 20.
_llvmlite_set_llvm_config() {
	export LLVM_CONFIG=${LLVM_CONFIG:-/usr/lib/llvm/20/bin/llvm-config}
	if [[ ! -x ${LLVM_CONFIG} ]]; then
		# Fallback to slotted binary name if path layout changes.
		if type -P llvm-config-20 >/dev/null ; then
			export LLVM_CONFIG=$(type -P llvm-config-20)
		fi
	fi
	[[ -x ${LLVM_CONFIG} ]] || die "Could not find llvm-config for slot 20; is sys-devel/llvm:20 installed?"
}

pkg_pretend() {
	# Make failures clearer before build.
	has_version "sys-devel/llvm:20" || die "llvmlite-9999 requires sys-devel/llvm:20 per upstream compatibility."
}

src_prepare() {
	default
}

python_compile() {
	_llvmlite_set_llvm_config
	distutils-r1_python_compile
}

python_test() {
	_llvmlite_set_llvm_config
	# Upstream uses pytest; keep it simple for live builds.
	# Disable slow/network tests if any appear.
	epytest -k "not slow"
}

python_install() {
	_llvmlite_set_llvm_config
	distutils-r1_python_install
}

pkg_postinst() {
	elog "llvmlite was built against LLVM slot 20 using: ${LLVM_CONFIG:-/usr/lib/llvm/20/bin/llvm-config}"
	elog "If you switch slots, rebuild llvmlite accordingly."
}
