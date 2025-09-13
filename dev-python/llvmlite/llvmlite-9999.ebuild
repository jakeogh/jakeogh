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
DEPEND="
	|| (
		llvm-core/llvm:21
		llvm-core/llvm:20
		llvm-core/llvm:19
		llvm-core/llvm:18
		sys-devel/llvm:21
		sys-devel/llvm:20
		sys-devel/llvm:19
		sys-devel/llvm:18
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
		if has_version "llvm-core/llvm:${slot}" || has_version "sys-devel/llvm:${slot}"; then
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

	die "Could not find a usable llvm-config (tried slots 21,20,19,18). Install llvm-core/llvm or sys-devel/llvm in one of those slots."
}

pkg_pretend() {
	elog "llvmlite-9999 auto-selects newest installed LLVM slot (21→20→19→18)."
	elog "Override with:  env LLVMLITE_LLVM_SLOT=21   or   env LLVM_CONFIG=/path/to/llvm-config"
	elog "This ebuild forces shared linking (llvm-config --link-shared + LLVM_LINK_LLVM_DYLIB=ON)."
}

src_prepare() {
	default

	# 1) Force monolithic linking in CMake (helps on some setups)
	if [[ -f ffi/CMakeLists.txt ]]; then
		if ! grep -q 'LLVM_LINK_LLVM_DYLIB' ffi/CMakeLists.txt ; then
			sed -i '1i set(LLVM_LINK_LLVM_DYLIB ON)' ffi/CMakeLists.txt \
				|| die "Failed to inject LLVM_LINK_LLVM_DYLIB into ffi/CMakeLists.txt"
		fi
	fi

	# 2) **Critical fix**: ensure build.py asks llvm-config for shared linkage
	# Convert any llvm-config ... --libs ... → llvm-config --link-shared --libs ...
	if [[ -f ffi/build.py ]]; then
		sed -i "s/'--libs'/'--link-shared', '--libs'/g" ffi/build.py || die
		sed -i 's/"--libs"/"--link-shared", "--libs"/g' ffi/build.py || die
	fi
}

python_compile() {
	_llvmlite_set_llvm_config
	# llvmlite respects $LLVM_CONFIG; our patches force shared lib (-lLLVM-XX) instead of dozens of per-component libs.
	distutils-r1_python_compile
}
