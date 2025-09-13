# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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

BDEPEND="
	${PYTHON_DEPS}
	dev-build/cmake
	dev-build/ninja
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

# Accept any reasonable slot from either the new (llvm-core/*) or old (sys-devel/*) category.
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

RESTRICT="!test? ( test )"

# Phase-local helper to choose llvm-config
_llvmlite_set_llvm_config() {
	local slot path
	if [[ -n ${LLVM_CONFIG} && -x ${LLVM_CONFIG} ]]; then
		export LLVMLITE_SELECTED_SLOT="(LLVM_CONFIG override)"
		return
	fi
	if [[ -n ${LLVMLITE_LLVM_SLOT} ]]; then
		slot=${LLVMLITE_LLVM_SLOT}
		path=/usr/lib/llvm/${slot}/bin/llvm-config
		if [[ ! -x ${path} ]] && type -P llvm-config-${slot} >/dev/null; then
			path=$(type -P llvm-config-${slot})
		fi
		[[ -x ${path} ]] || die "LLVMLITE_LLVM_SLOT=${slot} set, but no llvm-config found."
		export LLVM_CONFIG=${path}
		export LLVMLITE_SELECTED_SLOT=${slot}
		return
	fi
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
	die "Could not find a usable llvm-config (tried slots 21,20,19,18)."
}

pkg_pretend() {
	elog "This live ebuild auto-selects the newest installed LLVM slot (21→20→19→18)."
	elog "Override with env:  LLVMLITE_LLVM_SLOT=21   or   LLVM_CONFIG=/path/to/llvm-config"
	elog "We also force linking against the monolithic libLLVM (LLVM_LINK_LLVM_DYLIB=ON)."
}

src_prepare() {
	default

	# Force llvmlite's CMake to link against the monolithic libLLVM rather than per-component libs.
	# We patch ffi/build.py to add -DLLVM_LINK_LLVM_DYLIB=ON to the cmake configure invocation.
	# This avoids missing -lLLVM*AsmParser errors on Gentoo's llvm-core packages.
	edos2unix ffi/build.py || die
	eapply -p0 - <<'EOF'
*** ffi/build.py.orig	2025-01-01
--- ffi/build.py	2025-01-01
***************
*** 160,171 ****
      # Configure
-     cfg_cmd = ['cmake', '-G', 'Unix Makefiles', srcdir]
+     cfg_cmd = ['cmake', '-G', 'Unix Makefiles',
+                '-DLLVM_LINK_LLVM_DYLIB=ON',  # prefer monolithic libLLVM
+                srcdir]
      if sys.platform == 'win32':
          # (windows specifics omitted)
          pass
      subprocess.check_call(cfg_cmd)

      # Build
      build_cmd = ['cmake', '--build', builddir, '--parallel', '--config', 'Release']
      subprocess.check_call(build_cmd)
EOF
}

python_compile() {
	_llvmlite_set_llvm_config
	# $LLVM_CONFIG is respected by llvmlite's build, and our patch makes cmake use libLLVM.
	distutils-r1_python_compile
}

python_test() {
	_llvmlite_set_llvm_config
	epytest -k "not slow"
}

python_install() {
	_llvmlite_set_llvm_config
	distutils-r1_python_install
}

pkg_postinst() {
	elog "Built with LLVM_CONFIG=${LLVM_CONFIG} (slot ${LLVMLITE_SELECTED_SLOT})."
	elog "We forced LLVM_LINK_LLVM_DYLIB=ON to avoid missing per-target AsmParser libs."
	elog "To force a particular slot next time: env LLVMLITE_LLVM_SLOT=21 emerge -1 dev-python/llvmlite"
}
