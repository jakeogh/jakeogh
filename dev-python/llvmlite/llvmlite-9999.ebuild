# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# llvmlite builds a tiny C++ shim (CMake/ninja) and installs Python via setuptools (PEP 517).
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit git-r3 distutils-r1

DESCRIPTION="Lightweight LLVM Python binding used by Numba (live ebuild)"
HOMEPAGE="https://llvmlite.pydata.org/ https://github.com/numba/llvmlite"
EGIT_REPO_URI="https://github.com/numba/llvmlite.git"
EGIT_BRANCH="main"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="test"

# Hook pytest if USE=test
distutils_enable_tests pytest

BDEPEND="
	${PYTHON_DEPS}
	dev-build/cmake
	dev-build/ninja
"

# Accept LLVM from either new (llvm-core/*) or old (sys-devel/*) categories; pick newest slot at build time.
# CRITICAL: Add static-libs USE flag dependency
DEPEND="
	|| (
		llvm-core/llvm:21[static-libs]
		llvm-core/llvm:20[static-libs]
		llvm-core/llvm:19[static-libs]
		llvm-core/llvm:18[static-libs]
		sys-devel/llvm:21[static-libs]
		sys-devel/llvm:20[static-libs]
		sys-devel/llvm:19[static-libs]
		sys-devel/llvm:18[static-libs]
	)
"
RDEPEND="${DEPEND}"

# Phase-local helper: choose LLVM slot and set LLVM_CONFIG
_llvmlite_set_llvm_config() {
	local slot path

	# Respect explicit overrides
	if [[ -n ${LLVM_CONFIG} && -x ${LLVM_CONFIG} ]]; then
		export LLVMLITE_SELECTED_SLOT="(from LLVM_CONFIG)"
		return
	fi
	if [[ -n ${LLVMLITE_LLVM_SLOT} ]]; then
		slot=${LLVMLITE_LLVM_SLOT}
		path=/usr/lib/llvm/${slot}/bin/llvm-config
		if [[ ! -x ${path} ]] && type -P llvm-config-${slot} >/dev/null; then
			path=$(type -P llvm-config-${slot})
		fi
		[[ -x ${path} ]] || die "LLVMLITE_LLVM_SLOT=${slot} set, but no matching llvm-config found."
		export LLVM_CONFIG=${path}
		export LLVMLITE_SELECTED_SLOT=${slot}
		return
	fi

	# Auto-pick newest installed slot (21 → 20 → 19 → 18)
	for slot in 21 20 19 18; do
		if has_version "llvm-core/llvm:${slot}[static-libs]" || has_version "sys-devel/llvm:${slot}[static-libs]"; then
			path=/usr/lib/llvm/${slot}/bin/llvm-config
			if [[ ! -x ${path} ]] && type -P llvm-config-${slot} >/dev/null; then
				path=$(type -P llvm-config-${slot})
			fi
			if [[ -x ${path} ]]; then
				export LLVM_CONFIG=${path}
				export LLVMLITE_SELECTED_SLOT=${slot}
				return
			fi
		fi
	done

	die "Could not find a usable llvm-config with static-libs (tried slots 21,20,19,18). Install llvm-core/llvm[static-libs] or sys-devel/llvm[static-libs] in one of those slots."
}

pkg_pretend() {
	elog "llvmlite-9999 auto-selects newest installed LLVM slot (21→20→19→18) with static-libs."
	elog "Override with:  env LLVMLITE_LLVM_SLOT=21   or   env LLVM_CONFIG=/path/to/llvm-config"
	elog "This ebuild requires LLVM with static-libs USE flag for proper linking."
}

src_prepare() {
	default

	# Remove the shared linking modifications since we need static libs
	# The original build system should work correctly with static libraries
}

python_compile() {
	_llvmlite_set_llvm_config

	# Check what linking mode LLVM supports
	local llvm_libdir=$($LLVM_CONFIG --libdir)
	einfo "Using LLVM from: $($LLVM_CONFIG --version) at $llvm_libdir"

	# Check if shared LLVM library exists
	if [[ -f "$llvm_libdir/libLLVM.so" ]] || [[ -f "$llvm_libdir/libLLVM-$($LLVM_CONFIG --version | cut -d. -f1).so" ]]; then
		einfo "Found shared LLVM library, using shared linking"
	else
		ewarn "No shared LLVM library found, build may fail without static-libs"
	fi

	distutils-r1_python_compile
}

