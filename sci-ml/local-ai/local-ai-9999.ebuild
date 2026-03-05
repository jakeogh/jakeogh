# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
# NOTE: The C++ backends (llama.cpp, whisper.cpp, etc.) are git submodules.
# EGIT_SUBMODULES='*' pulls them all in. This makes the initial clone large (~1-2 GB).
EGIT_REPO_URI="https://github.com/mudler/LocalAI.git"
EGIT_SUBMODULES=( '*' )

# go-module: for a 9999/live ebuild, EGO_SUM is impractical since go.sum changes
# continuously. We use GOFLAGS=-mod=mod and allow network during build instead.
# Add to /etc/portage/package.env:
#   app-misc/local-ai network-sandbox.conf
# with network-sandbox.conf containing: FEATURES="-network-sandbox"
inherit git-r3 go-module toolchain-funcs flag-o-matic

DESCRIPTION="Free, Open Source alternative to OpenAI. Self-hosted and local-first."
HOMEPAGE="https://localai.io https://github.com/mudler/LocalAI"

LICENSE="MIT Apache-2.0 BSD"
SLOT="0"
KEYWORDS=""

# GPU backend USE flags map to Makefile BUILD_TYPE values:
#   cuda    → cublas
#   rocm    → hipblas
#   opencl  → clblas
#   vulkan  → vulkan
#   openblas → openblas
#   (none)  → pure CPU / BLAS fallback
#
# Only one GPU backend can be active at build time.
IUSE="cpu cuda rocm opencl vulkan openblas"
REQUIRED_USE="
	?? ( cuda rocm opencl vulkan )
	openblas? ( !cuda !rocm )
"

# upx: used by the Makefile to compress the final binary (upx-ucl in Dockerfile)
# protobuf: provides protoc for make protogen-go
# git-lfs: some backend sources use LFS objects
# protoc-gen-go / protoc-gen-go-grpc: installed via `go install` in upstream;
#   if Gentoo packages exist use them, otherwise they're fetched by go-module.
#   dev-go/protoc-gen-go and dev-go/protoc-gen-go-grpc may need separate ebuilds.
BDEPEND="
	>=dev-lang/go-1.25
	>=dev-build/cmake-3.28
	dev-libs/protobuf
	dev-vcs/git-lfs
	app-arch/upx
	virtual/pkgconfig
	dev-go/protoc-gen-go-grpc
	cuda? ( dev-util/nvidia-cuda-toolkit )
	rocm? ( dev-util/hip )
	opencl? ( virtual/opencl )
	vulkan? ( dev-util/vulkan-headers )
"

# NOTE: dev-go/protoc-gen-go (protobuf, not grpc) does not appear to be in the
# Gentoo tree as of 2026-03; the ebuild installs it via `go install` at build time.

RDEPEND="
	app-accessibility/espeak-ng
	media-video/ffmpeg
	media-sound/sox
	sys-devel/gcc[openmp]
	openblas? ( sci-libs/openblas )
	cuda? (
		dev-util/nvidia-cuda-toolkit
		x11-drivers/nvidia-drivers[utils]
	)
	rocm? (
		sci-libs/hipBLAS
		sci-libs/hipBLAS-common
		sci-libs/rocblas
	)
	opencl? (
		sci-libs/clblast
		virtual/opencl
	)
	vulkan? (
		media-libs/vulkan-loader
		media-libs/mesa[vulkan]
	)
"

DEPEND="${RDEPEND}"

# Live ebuilds need network for `go mod download` — the Makefile runs this
# internally before the Go build. Disable the network sandbox via package.env.
RESTRICT="test"

pkg_pretend() {
	if [[ "${FEATURES}" == *network-sandbox* ]]; then
		ewarn "This ebuild requires network access during build for Go module downloads."
		ewarn "Add to /etc/portage/package.env:"
		ewarn "  app-misc/local-ai network-sandbox.conf"
		ewarn "With network-sandbox.conf containing: FEATURES=\"-network-sandbox\""
	fi
}

src_unpack() {
	git-r3_src_unpack

	# git-lfs objects are needed by some C++ backend submodules
	cd "${S}" || die
	git lfs install --local || die
	git lfs pull || die
}

src_configure() {
	# Determine BUILD_TYPE from USE flags
	local build_type=""

	if use cuda; then
		build_type="cublas"
	elif use rocm; then
		build_type="hipblas"
	elif use opencl; then
		build_type="clblas"
	elif use vulkan; then
		build_type="vulkan"
	elif use openblas; then
		build_type="openblas"
	fi
	# pure cpu: BUILD_TYPE stays empty, upstream Makefile defaults to openblas-less CPU

	export BUILD_TYPE="${build_type}"
	einfo "BUILD_TYPE=${BUILD_TYPE:-<cpu default>}"

	# Pass CPU arch. LocalAI/llama.cpp uses MARCH for native optimisations.
	# Let Gentoo's CFLAGS drive this rather than -march=native blindly.
	export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_BUILD_TYPE=Release"

	# Go environment — allow the module graph to be updated during build
	export GOFLAGS="-mod=mod"
	export GOPATH="${T}/gopath"
	export GOCACHE="${T}/gocache"
	export CGO_ENABLED=1
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_CXXFLAGS="${CXXFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"

	# Strip debug symbols via LD_FLAGS consistent with upstream defaults
	export LD_FLAGS="-s -w -X 'github.com/mudler/LocalAI/internal.Version=9999-gentoo' -X \"github.com/mudler/LocalAI/internal.Commit=$(git -C "${S}" rev-parse --short HEAD 2>/dev/null || echo unknown)\""

	# CUDA-specific: point to toolkit headers/libs
	if use cuda; then
		local cuda_root
		cuda_root="$(cuda_gccdir 2>/dev/null || echo /usr/local/cuda)"
		export PATH="${cuda_root}/bin:${PATH}"
		export CMAKE_ARGS="${CMAKE_ARGS} -DCUDA_TOOLKIT_ROOT_DIR=${cuda_root}"
	fi

	# ROCm-specific
	if use rocm; then
		export PATH="/opt/rocm/bin:${PATH}"
		export CMAKE_ARGS="${CMAKE_ARGS} -DAMDGPU_TARGETS=${AMDGPU_TARGETS:-gfx1100}"
	fi
}

src_compile() {
	# Step 1: generate gRPC/protobuf Go stubs
	# protoc must be on PATH (from dev-libs/protobuf)
	# protoc-gen-go and protoc-gen-go-grpc are fetched via go install if not present
	einfo "Running protogen-go..."

	if ! command -v protoc-gen-go &>/dev/null || ! command -v protoc-gen-go-grpc &>/dev/null; then
		einfo "Installing protoc-gen-go and protoc-gen-go-grpc into GOPATH..."
		go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.34.2 || die
		go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.3.0 || die
		export PATH="${GOPATH}/bin:${PATH}"
	fi

	emake protogen-go

	# Step 2: build the LocalAI binary
	einfo "Running make build (BUILD_TYPE=${BUILD_TYPE:-<cpu>})..."
	emake \
		BUILD_TYPE="${BUILD_TYPE}" \
		LD_FLAGS="${LD_FLAGS}" \
		GO_TAGS="${GO_TAGS}" \
		build
}

src_install() {
	dobin local-ai

	# Runtime directory layout expected by LocalAI
	keepdir /var/lib/local-ai/models
	keepdir /var/lib/local-ai/backends
	keepdir /etc/local-ai

	# Default configuration placeholder
	insinto /etc/local-ai
	newins - local-ai.env <<-'EOF'
		# LocalAI environment configuration
		# See https://localai.io/advanced/ for available options
		ADDRESS=0.0.0.0:8080
		MODELS_PATH=/var/lib/local-ai/models
		BACKENDS_PATH=/var/lib/local-ai/backends
		CONFIG_FILE=/etc/local-ai/config.yaml
	EOF

	# OpenRC init script
	# NOTE: systemd excluded per user preferences
	newconfd - local-ai <<-'EOF'
		# /etc/conf.d/local-ai
		LOCALAI_OPTS=""
		LOCALAI_USER="local-ai"
		LOCALAI_GROUP="local-ai"
	EOF

	newinitd - local-ai <<-'EOF'
		#!/sbin/openrc-run
		name="LocalAI"
		description="Local AI inference server"
		command="/usr/bin/local-ai"
		command_args="${LOCALAI_OPTS}"
		command_user="${LOCALAI_USER}:${LOCALAI_GROUP}"
		pidfile="/run/${RC_SVCNAME}.pid"
		command_background=yes
		env_file="/etc/local-ai/local-ai.env"

		depend() {
			need net
			after logger
		}
	EOF

	dodoc README.md
}

pkg_postinst() {
	elog "LocalAI is installed. Before starting:"
	elog "  1. Review /etc/local-ai/local-ai.env"
	elog "  2. Create the local-ai user: useradd -r -m -d /var/lib/local-ai local-ai"
	elog "  3. Ensure ${ROOT}/var/lib/local-ai/models is writable by that user"
	elog ""
	elog "Backends are downloaded at runtime by default. To pre-install a backend"
	elog "or model, see: https://localai.io/models/"
	if use cuda; then
		elog ""
		elog "CUDA build: ensure NVIDIA drivers and cuda toolkit versions match."
	fi
	if use rocm; then
		elog ""
		elog "ROCm build: set HSA_OVERRIDE_GFX_VERSION if your GPU arch is not auto-detected."
	fi
}
