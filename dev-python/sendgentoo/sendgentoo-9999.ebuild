# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="Install Gentoo Linux"
HOMEPAGE="https://github.com/jakeogh/sendgentoo"
EGIT_REPO_URI="https://github.com/jakeogh/sendgentoo.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""
LICENSE="MIT"

#	app-emulation/qemu[static-user,qemu_softmmu_targets_aarch64,qemu_softmmu_targets_alpha,qemu_softmmu_targets_arm,qemu_softmmu_targets_avr,qemu_softmmu_targets_cris,qemu_softmmu_targets_hppa,qemu_softmmu_targets_i386,qemu_softmmu_targets_lm32,qemu_softmmu_targets_m68k,qemu_softmmu_targets_microblaze,qemu_softmmu_targets_microblazeel,qemu_softmmu_targets_mips,qemu_softmmu_targets_mips64,qemu_softmmu_targets_mips64el,qemu_softmmu_targets_mipsel,qemu_softmmu_targets_moxie,qemu_softmmu_targets_nios2,qemu_softmmu_targets_or1k,qemu_softmmu_targets_ppc,qemu_softmmu_targets_ppc64,qemu_softmmu_targets_riscv32,qemu_softmmu_targets_riscv64,qemu_softmmu_targets_rx,qemu_softmmu_targets_s390x,qemu_softmmu_targets_sh4,qemu_softmmu_targets_sh4eb,qemu_softmmu_targets_sparc,qemu_softmmu_targets_sparc64,qemu_softmmu_targets_tricore,qemu_softmmu_targets_unicore32,qemu_softmmu_targets_x86_64,qemu_softmmu_targets_xtensa,qemu_softmmu_targets_xtensaeb,qemu_user_targets_aarch64,qemu_user_targets_aarch64_be,qemu_user_targets_alpha,qemu_user_targets_arm,qemu_user_targets_armeb,qemu_user_targets_cris,qemu_user_targets_hexagon,qemu_user_targets_hppa,qemu_user_targets_i386,qemu_user_targets_m68k,qemu_user_targets_microblaze,qemu_user_targets_microblazeel,qemu_user_targets_mips,qemu_user_targets_mips64,qemu_user_targets_mips64el,qemu_user_targets_mipsel,qemu_user_targets_mipsn32,qemu_user_targets_mipsn32el,qemu_user_targets_nios2,qemu_user_targets_or1k,qemu_user_targets_ppc,qemu_user_targets_ppc64,qemu_user_targets_ppc64abi32,qemu_user_targets_ppc64le,qemu_user_targets_riscv32,qemu_user_targets_riscv64,qemu_user_targets_s390x,qemu_user_targets_sh4,qemu_user_targets_sh4eb,qemu_user_targets_sparc,qemu_user_targets_sparc64,qemu_user_targets_x86_64,qemu_user_targets_xtensa]
# parted likes dmidecode, should send a patch for the ebuild
# debianutils should provide ischroot: https://bugs.gentoo.org/698812
RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/python-dmenu[${PYTHON_USEDEP}]
	sys-apps/debianutils
	sys-fs/cryptsetup
	sys-fs/dosfstools
	sys-block/parted
	sys-apps/gptfdisk
	sys-apps/openrc
	sys-apps/dmidecode
	dev-python/humanfriendly[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	sys-apps/pv
	dev-python/retry-on-exception[${PYTHON_USEDEP}]
	dev-tcltk/expect
	dev-python/humanfriendly[${PYTHON_USEDEP}]
	sys-apps/debianutils
	dev-python/pexpect[${PYTHON_USEDEP}]
	dev-python/compile-kernel[${PYTHON_USEDEP}]
	dev-python/devicetool[${PYTHON_USEDEP}]
	dev-python/mounttool[${PYTHON_USEDEP}]
	dev-python/nettool[${PYTHON_USEDEP}]
	dev-python/itertool[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/timetool[${PYTHON_USEDEP}]
	dev-python/symlinktree[${PYTHON_USEDEP}]
	dev-python/portagetool[${PYTHON_USEDEP}]
	dev-python/sendgentoo-post-reboot[${PYTHON_USEDEP}]
	dev-python/sendgentoo-chroot[${PYTHON_USEDEP}]
	dev-python/sendgentoo-stage[${PYTHON_USEDEP}]
	dev-python/zfstool[${PYTHON_USEDEP}]
	dev-python/boottool[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	app-portage/smart-live-rebuild[${PYTHON_USEDEP}]
	dev-libs/glib[static-libs]
	sys-apps/attr[static-libs]
	sys-libs/zlib[static-libs]
	dev-libs/libpcre[static-libs]
	"

#	sys-apps/fchroot
#	dev-python/sendgentoo-post-chroot[${PYTHON_USEDEP}]
DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
