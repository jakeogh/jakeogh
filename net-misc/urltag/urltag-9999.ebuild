# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..13} )
inherit python-single-r1

DESCRIPTION="URL tagging and derivation engine on zaphash + zbtree"
HOMEPAGE="https://github.com/FIXME/urltag"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="file:///home/sysskel/myapps/urltag"
fi

LICENSE="CDDL"
SLOT="0"
KEYWORDS=""
IUSE="benchmark"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	sys-fs/zaphash
	sys-fs/zbtree
	$(python_gen_cond_dep '
		dev-python/msgpack[${PYTHON_USEDEP}]
	')
"
BDEPEND="${PYTHON_DEPS}"

src_install() {
	python_fix_shebang .

	# importable modules → site-packages
	python_domodule urltag.py
	python_domodule urltag_derive.py
	python_domodule urltag_import_mp.py
	python_domodule urltag_hist.py

	# CLI entry points
	python_newscript urltag.py urltag
	python_newscript urltag_derive.py urltag-derive
	python_newscript urltag_import_mp.py urltag-import
	python_newscript urltag_hist.py urltag-hist

	if use benchmark; then
		insinto /usr/share/${PN}/benchmark
		doins benchmark/*
	fi

	einstalldocs
}
