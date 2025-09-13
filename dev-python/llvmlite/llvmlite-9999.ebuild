# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# PEP 517 backend is setuptools; llvmlite builds a C++ core via cmake/ninja.
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

# Pick exactly one LLVM slot. Default to 18 since that's what you have.
IUSE="+llvm_slot_18 llvm_slot_20 test"
REQUIRED_USE="^^ ( llvm_slot_18 llvm_slot_20 )"

BDEPEND="
	${PYTHON_DEPS}
	dev-build/cmake
	dev-build/ninja
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"
# Conditionally depend on the slotted LLVM; no use() at global scope.
DEPEND="
	llvm_slot_18? ( sys-devel/llvm:18 )
	llvm_slot_20? ( sys-devel/llvm:20 )
"
RDEPEND="${DEPEND}"

RESTRICT="!test? ( test )"

# Pick the llvm-config path for the selected slot (phase-scope only).
_llvmlite_set_llvm_config() {
	local slot path
	if use llvm_slot_20 ; then
		slot=20
	else
		slot=18
	fi

	path=/usr/lib/llvm/${slot}/bin/llvm-config
	if [[ ! -x ${path} ]] && type -P llvm-config-${slot} >/dev/null ; then
		path=$(type -P llvm-config-${slot})
	fi
	[[ -x ${path} ]] || die "Could not find llvm-config for slot ${slot}"
	export LLVM_CONFIG=${path}
	export LLVMLITE_SELECTED_SLOT=${slot}
}

pkg_pretend() {
	if use llvm_slot_18 ; then
		elog "Building against LLVM slot 18. Upstream 'main' may require LLVM 20 on some commits."
		elog "If you hit version-check failures, install sys-devel/llvm:20 and enable USE=llvm_slot_20."
	fi
	if use llvm_slot_20 ; then
		elog "Building against LLVM slot 20 (recommended by upstream main)."
	fi
}

src_prepare() {
	default
}

python_compile() {
	_llvmlite_set_llvm_config
	# llvmlite's build system respects $LLVM_CONFIG
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
	elog "Switch slots by toggling USE flags: +llvm_slot_18 or +llvm_slot_20 (mutually exclusive)."
}

