# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="reads messagepacked bytes on stdin and prints their type and metadata to stdout"
HOMEPAGE="https://github.com/jakeogh/mptypez"
EGIT_REPO_URI="https://github.com/jakeogh/mptypez.git"

# Zig dependency
ZIG_MSGPACK_COMMIT="main"
SRC_URI="https://github.com/zigcc/zig-msgpack/archive/${ZIG_MSGPACK_COMMIT}.tar.gz -> zig-msgpack-${ZIG_MSGPACK_COMMIT}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND=">=dev-lang/zig-0.14.0"
RDEPEND=""

src_prepare() {
	default

	# Extract zig-msgpack as a local dependency
	mkdir -p deps/zig-msgpack || die
	tar -xzf "${DISTDIR}/zig-msgpack-${ZIG_MSGPACK_COMMIT}.tar.gz" \
		--strip-components=1 -C deps/zig-msgpack || die "Failed to extract zig-msgpack"

	# Create a simplified build.zig that uses the local dependency
	cat > build.zig << 'EOF'
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "msgpack-reader",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Add the local zig-msgpack dependency
    const msgpack_module = b.addModule("msgpack", .{
        .root_source_file = b.path("deps/zig-msgpack/src/msgpack.zig"),
    });
    exe.root_module.addImport("msgpack", msgpack_module);

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const unit_tests = b.addTest(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    unit_tests.root_module.addImport("msgpack", msgpack_module);

    const run_unit_tests = b.addRunArtifact(unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);
}
EOF

	# Create a simplified build.zig.zon without external dependencies
	cat > build.zig.zon << 'EOF'
.{
    .name = .msgpack_reader,
    .version = "0.1.0",
    .minimum_zig_version = "0.14.0",

    .paths = .{
        "build.zig",
        "build.zig.zon",
        "src",
        "deps",
    },
}
EOF
}

src_compile() {
	# Build with local dependencies
	zig build -Doptimize=ReleaseSafe || die "compilation failed"

}

src_install() {
	dobin zig-out/bin/msgpack-reader

	# Create a symlink with the package name
	dosym msgpack-reader /usr/bin/mptypez
}
