# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="convert iiw files to csv on stdout"
HOMEPAGE="https://github.com/jakeogh/iiw2csv"
EGIT_REPO_URI="https://github.com/jakeogh/iiw2csv.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
PROPERTIES="live"

IUSE="static-musl native"

# Build-time Zig only
BDEPEND=">=dev-lang/zig-0.14.0"

# Repo layout: file lives at iiw2csv/iiw2csv.zig under project root
# git-r3 sets S=${WORKDIR}/${P}
# We'll emit the binary into ${T} and install from there.

src_compile() {
	# Keep Zig caches inside the sandbox
	export HOME="${T}"
	export ZIG_GLOBAL_CACHE_DIR="${T}/zig-global-cache"
	export ZIG_LOCAL_CACHE_DIR="${T}/zig-local-cache"

	local target
	if use static-musl; then
		# portable static build (no glibc deps)
		case ${CHOST} in
			x86_64*) target="x86_64-linux-musl" ;;
			aarch64*) target="aarch64-linux-musl" ;;
			*)        target="" ;;  # fall back to host libc if unknown
		esac
	else
		target=""  # host default (glibc), fastest build
	fi

	local mcpu="baseline"
	use native && mcpu="native"

	# Build
	zig build-exe \
		-OReleaseFast -fstrip \
		${target:+-target "${target}"} \
		-mcpu="${mcpu}" \
		-femit-bin="${T}/iiw2csv" \
		"${S}/iiw2csv/iiw2csv.zig" \
		|| die "zig build-exe failed"
}

src_install() {
	dobin "${T}/iiw2csv" || die
	einstalldocs
}
