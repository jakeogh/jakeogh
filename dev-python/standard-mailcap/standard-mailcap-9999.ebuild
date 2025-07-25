# Copyright 2025
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="Portable mailcap module compatible with modern Python versions"
HOMEPAGE="https://github.com/youknowone/python-deadlib"
EGIT_REPO_URI="https://github.com/youknowone/python-deadlib.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT="test"

src_prepare() {
    default

    rm -rf dead six tests || die

    # Move the single source file into place
    mv mailcap/mailcap.py ./standard_mailcap.py || die "Failed to move mailcap.py"

    cat > setup.py <<EOF || die
from setuptools import setup

setup(
    name="standard-mailcap",
    version="9999",
    description="Portable mailcap module compatible with modern Python versions",
    author="youknowone",
    url="https://github.com/youknowone/python-deadlib",
    py_modules=["standard_mailcap"],
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
    ],
    license="MIT",
    python_requires=">=3.6",
)
EOF
}
