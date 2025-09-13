# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# llvmlite uses setuptools (PEP517) and builds a C++ core via cmake/ninja.
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

# Build tools + optional tests
BDEPEND="
	${PYTHON_DEPS}
	dev-build/cmake
	dev-build/ninja
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

# Accept any *one* of these LLVM slots from either old or new category
# (Gentoo moved LLVM to category llvm-core/ in 2024/2025).
# We’ll auto-pick the newest available during the phase functions.
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

# Picks an llvm-config for the newest installed slot unless overridden:
#   - export LLVMLITE_LLVM_SLOT=21 (or 20/19/18), OR
#   - export LLVM_CONFIG=/path/to/llvm-config
_llvmlite_set_llvm_config() {
	local slot path
	if [[ -n ${LLVM_CONFIG} && -x ${LLVM_CONFIG} ]]; then
		export LLVMLITE_SELECTED_SLOT="(from LLVM_CONFIG)"
		return
	fi

	# Respect explicit slot override first
	if [[ -n ${LLVMLITE_LLVM_SLOT} ]]; then
		slot=${LLVMLITE_LLVM_SLOT}
		path=/usr/lib/llvm/${slot}/bin/llvm-config
		if [[ ! -x ${path} ]] && type -P llvm-config-${slot} >/dev/null ; then
			path=$(type -P llvm-config-${slot})
		fi
		[[ -x ${path} ]] || die "LLVMLITE_LLVM_SLOT=${slot} set, but no llvm-config for that slot found."
		export LLVM_CONFIG=${path}
		export LLVMLITE_SELECTED_SLOT=${slot}
		return
	fi

	# Auto-pick newest available slot
	for slot in 21 20 19 18; do
		if has_version "llvm-core/llvm:${slot}" || has_version "sys-devel/llvm:${slot}"; then
			path=/usr/lib/llvm/${slot}/bin/llvm-config
			if [[ ! -x ${path} ]] && type -P llvm-config-${slot} >/dev/null ; then
				path=$(type -P llvm-config-${slot})
			fi
			if [[ -x ${path} ]]; then
				export LLVM_CONFIG=${path}
				export LLVMLITE_SELECTED_SLOT=${slot}
				return
			fi
		fi
	done

	die "Could not find a usable llvm-config (tried slots 21,20,19,18). Install one of: llvm-core/llvm:{21,20,19,18} (or sys-devel/llvm:{…})."
}

pkg_pretend() {
	elog "This live ebuild will auto-select the newest installed LLVM slot (21→20→19→18)."
	elog "Override with:  LLVMLITE_LLVM_SLOT=21   or   LLVM_CONFIG=/path/to/llvm-config"
	elog "If build fails due to a strict LLVM version check in llvmlite 'main', install a newer slot and rebuild."
}

src_prepare() {
	default
}

python_compile() {
	_llvmlite_set_llvm_config
	# llvmlite's build respects $LLVM_CONFIG
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
	elog "llvmlite-9999 was built using: ${LLVM_CONFIG} (slot ${LLVMLITE_SELECTED_SLOT})"
	elog "To force a slot next time: export LLVMLITE_LLVM_SLOT=21 (or 20/19/18) before emerging,"
	elog "or point LLVM_CONFIG to the exact binary."
}
