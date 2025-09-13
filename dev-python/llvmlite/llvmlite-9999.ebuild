# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# llvmlite builds a small C++ shim (via CMake/ninja) and installs Python wheels via setuptools (PEP 517).
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

# Let distutils-r1 add pytest deps/targets when USE=test
distutils_enable_tests pytest

BDEPEND="
	${PYTHON_DEPS}
	dev-build/cmake
	dev-build/ninja
"

# Accept an LLVM from either new (llvm-core/*) or old (sys-devel/*) categories,
# and from one of these slots. We'll select the newest installed slot at build time.
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

# Helper: choose LLVM slot and set LLVM_CONFIG accordingly (phase scope only).
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

	# Auto-pick newest installed slot (21 -> 20 -> 19 -> 18)
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
	elog "llvmlite-9999 will auto-select the newest installed LLVM slot (21→20→19→18)."
	elog "Override with:   env LLVMLITE_LLVM_SLOT=21   or   env LLVM_CONFIG=/path/to/llvm-config"
	elog "This ebuild also forces CMake to link the monolithic libLLVM (LLVM_LINK_LLVM_DYLIB=ON)."
}

src_prepare() {
	default

	# Force linking against monolithic libLLVM instead of per-component libs
	# by adding -DLLVM_LINK_LLVM_DYLIB=ON to the CMake configure command used by llvmlite's ffi/build.py
	# We patch robustly: inject the flag after the 'Unix Makefiles' generator argument.
	# No need for edos2unix/eapply; just sed.
	if [[ -f ffi/build.py ]]; then
		sed -i -E "s#(\['cmake',[[:space:]]*'-G',[[:space:]]*'Unix Makefiles')#\1, '-DLLVM_LINK_LLVM_DYLIB=ON'#" ffi/build.py \
			|| die "sed patch to add -DLLVM_LINK_LLVM_DYLIB=ON failed"
	fi
}

python_compile() {
	_llvmlite_set_llvm_config
	# llvmlite's build respects $LLVM_CONFIG and the CMake flag we injected above.
	distutils-r1_python_compile
}

python_install() {
	_llvmlite_set_llvm_config
	distutils-r1_python_install
}

pkg_postinst() {
	elog "llvmlite-9999 was built using LLVM_CONFIG=${LLVM_CONFIG} (slot ${LLVMLITE_SELECTED_SLOT})"
	elog "To force a particular slot next time: env LLVMLITE_LLVM_SLOT=21 emerge -1 dev-python/llvmlite"
}

