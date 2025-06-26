# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs multiprocessing

DESCRIPTION="OpenFOAM: CFD toolbox (v2412)"
HOMEPAGE="https://develop.openfoam.com/Development/openfoam https://openfoam.com"
SRC_URI="
    https://sourceforge.net/projects/openfoam/files/v${PV}/OpenFOAM-v${PV}.tgz -> OpenFOAM-${PV}.tar.gz
    https://sourceforge.net/projects/openfoam/files/v${PV}/ThirdParty-v${PV}.tgz -> ThirdParty-${PV}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mpi metis scotch paraview"


DEPEND="
    sys-libs/zlib
    dev-libs/boost
    sci-libs/fftw:3.0
    media-libs/libpng
    media-libs/libjpeg-turbo
    mpi? ( virtual/mpi )
    scotch? ( sci-libs/scotch[threads] )
    metis? ( sci-libs/metis )
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/OpenFOAM-v${PV}"

src_prepare() {
    default

    # Apply any patches here if needed
    eapply_user
}

src_compile() {
    # Build ThirdParty first
    einfo "Building ThirdParty"
    pushd "${WORKDIR}/ThirdParty-v${PV}" > /dev/null || die
    ./Allwmake -j$(makeopts_jobs) || die "ThirdParty build failed"
    popd > /dev/null || die

    # Now build OpenFOAM
    einfo "Building OpenFOAM"
    pushd "${S}" > /dev/null || die
    ./Allwmake -j$(makeopts_jobs) || die "OpenFOAM build failed"
    popd > /dev/null || die
}

src_test() {
    einfo "Running foamInstallationTest"
    source "${S}/etc/bashrc" > /dev/null
    foamInstallationTest || die "foamInstallationTest failed"
}

src_install() {
    # Install OpenFOAM tree into versioned directory
    local instdir="/usr/lib/OpenFOAM/${PV}"
    dodir "${instdir}"
    cp -a "${S}"/* "${ED}${instdir}" || die
    cp -a "${WORKDIR}/ThirdParty-v${PV}" "${ED}${instdir}/ThirdParty" || die

    # Install env setup script
    insinto /etc/profile.d
    newins - openfoam2412.sh <<-EOF
        export WM_PROJECT_VERSION=${PV}
        export FOAM_INST_DIR=/usr/lib/OpenFOAM
        source /usr/lib/OpenFOAM/${PV}/etc/bashrc
EOF
    chmod +x "${ED}/etc/profile.d/openfoam2412.sh" || die
}

